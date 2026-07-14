import 'package:flutter/foundation.dart';
import 'package:workmanager/workmanager.dart';
import 'package:rafiq/core/services/notification_service.dart';
import 'package:rafiq/core/database/objectbox.dart';
import 'package:rafiq/features/medications/data/models/medicine_object_box_model.dart';
import 'package:rafiq/features/medications/data/models/medicine_entity.dart';
import 'package:rafiq/core/services/session_manager.dart';
import 'package:rafiq/core/services/medication_encryption_service.dart';
import 'package:rafiq/core/services/i_background_service.dart';
import 'package:rafiq/objectbox.g.dart';
import 'dart:convert';

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    try {
      final objectBox = await ObjectBox.create();
      final store = objectBox.store;
      final box = store.box<MedicineEntity>();

      final currentUserEmail = await SessionManager.getCurrentUserEmail() ?? 'default_user';

      final activeEntities = box
          .query(
            MedicineEntity_.status.equals('active')
            .and(MedicineEntity_.userEmail.equals(currentUserEmail)),
          )
          .build()
          .find();

      final encryptionService = MedicationEncryptionService();
      final activeMedicines = <MedicineObjectBoxModel>[];
      for (var entity in activeEntities) {
        try {
          final decryptedJsonString = await encryptionService.decrypt(entity.encryptedData, entity.userEmail);
          final decryptedMap = json.decode(decryptedJsonString) as Map<String, dynamic>;
          final medicine = MedicineObjectBoxModel.fromJson(
            decryptedMap,
            objectBoxID: entity.objectBoxID,
            id: entity.apiId,
            status: entity.status,
          );
          activeMedicines.add(medicine);
        } catch (e) {
          if (kDebugMode) {
            print('Failed to decrypt medicine ${entity.apiId}: $e');
          }
        }
      }

      final notificationService = NotificationService.instance;
      await notificationService.initialize();

      final now = DateTime.now();
      final todayAtMidnight = DateTime(now.year, now.month, now.day);

      for (var medicine in activeMedicines) {
        // 1. Handle endDate cleanup
        if (medicine.endDate != null) {
          final endAtMidnight = DateTime(
            medicine.endDate!.year,
            medicine.endDate!.month,
            medicine.endDate!.day,
          );

          if (todayAtMidnight.isAfter(endAtMidnight)) {
            await _cancelAll(notificationService, medicine);
            continue;
          }
        }

        // 2. Schedule for next 3 days for Custom/Every X Days
        if (medicine.frequency == 'custom' && medicine.customInterval != null) {
          final startDateAtMidnight = DateTime(
            medicine.startDate.year,
            medicine.startDate.month,
            medicine.startDate.day,
          );
          final diffInDays = todayAtMidnight
              .difference(startDateAtMidnight)
              .inDays;
          final interval = medicine.customInterval!;
          final startCheck = todayAtMidnight.add(
            Duration(days: (interval - (diffInDays % interval)) % interval),
          );
          for (int i = 0; i < 3; i++) {
            final futureDate = startCheck.add(Duration(days: i * interval));

            // Check if futureDate exceeds endDate
            if (medicine.endDate != null) {
              final endAtMidnight = DateTime(
                medicine.endDate!.year,
                medicine.endDate!.month,
                medicine.endDate!.day,
              );
              if (futureDate.isAfter(endAtMidnight)) continue;
            }

            _scheduleForSpecificDate(notificationService, medicine, futureDate);
          }
        }
      }
      store.close();
      // Reschedule for next day
      await BackgroundTasks().scheduleNightlyTask();
      return Future.value(true);
    } catch (e) {
      if (kDebugMode) {
        print('Workmanager task failed: $e');
      }
      return Future.value(false);
    }
  });
}

Future<void> _cancelAll(
  NotificationService service,
  MedicineObjectBoxModel medicine,
) async {
  await service.cancelMedicineNotifications(medicine);
}

void _scheduleForSpecificDate(
  NotificationService service,
  MedicineObjectBoxModel medicine,
  DateTime date,
) {
  for (int i = 0; i < medicine.doseTimesStrings.length; i++) {
    final timeStr = medicine.doseTimesStrings[i];
    final parts = timeStr.split(':');
    final hour = int.parse(parts[0]);
    final minute = int.parse(parts[1]);

    final scheduledTime = DateTime(
      date.year,
      date.month,
      date.day,
      hour,
      minute,
    );

    service.scheduleOnce(
      id: service.generateId(
        medicineId: medicine.id,
        month: date.month,
        day: date.day,
        hour: hour,
        minute: minute,
      ),
      title: 'Medication Reminder',
      body: 'Time to take ${medicine.name} (${medicine.dosage})',
      scheduledDate: scheduledTime,
      payload: medicine.id,
    );
  }
}

class BackgroundTasks implements IBackgroundService {
  static const taskName = 'medicationNightlyTask';

  @override
  Future<void> initialize() async {
    await Workmanager().initialize(callbackDispatcher);
  }

  @override
  Future<void> scheduleNightlyTask() async {
    final now = DateTime.now();
    final target = DateTime(now.year, now.month, now.day + 1, 0, 0);
    final initialDelay = target.difference(now);

    await Workmanager().registerOneOffTask(
      '1',
      taskName,
      initialDelay: initialDelay,
      constraints: Constraints(networkType: NetworkType.notRequired),
    );
  }
}
