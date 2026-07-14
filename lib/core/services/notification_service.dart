import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:rafiq/features/medications/data/models/medicine_object_box_model.dart';
import 'package:rafiq/features/medications/presentation/enums/schedule_frequency.dart';
import 'package:rafiq/core/services/i_notification_service.dart';
import 'package:rafiq/core/router/router_strings.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class NotificationService implements INotificationService {
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal();

  static NotificationService get instance => _instance;

  final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  @override
  Future<void> initialize() async {
    tz.initializeTimeZones();

    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const DarwinInitializationSettings iosSettings =
        DarwinInitializationSettings(
          requestAlertPermission: true,
          requestBadgePermission: true,
          requestSoundPermission: true,
        );

    const InitializationSettings initSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _notificationsPlugin.initialize(
      initSettings,
      onDidReceiveNotificationResponse: (NotificationResponse details) {
        if (details.actionId == 'done' || details.actionId == 'cancel') {
          if (details.id != null) {
            cancelNotification(details.id!);
          }
        } else {
          // Handle notification tap (navigate to details)
          if (details.payload != null) {
            navigatorKey.currentState?.pushNamed(
              RouterStrings.medicationDetails,
              arguments: details.payload,
            );
          }
        }
      },
    );

    if (Platform.isAndroid) {
      await _notificationsPlugin
          .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin
          >()
          ?.requestNotificationsPermission();

      await _notificationsPlugin
          .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin
          >()
          ?.requestExactAlarmsPermission();
    }
  }

  @override
  Future<NotificationAppLaunchDetails?>
  getNotificationAppLaunchDetails() async {
    return await _notificationsPlugin.getNotificationAppLaunchDetails();
  }

  NotificationDetails _notificationDetails() {
    return const NotificationDetails(
      android: AndroidNotificationDetails(
        'medication_reminders',
        'Medication Reminders',
        channelDescription: 'Notifications for your medication schedule',
        importance: Importance.max,
        priority: Priority.high,
        ticker: 'ticker',
        actions: <AndroidNotificationAction>[
          AndroidNotificationAction('done', 'Done', showsUserInterface: false),
          AndroidNotificationAction(
            'cancel',
            'Cancel',
            showsUserInterface: false,
          ),
        ],
      ),
      iOS: DarwinNotificationDetails(),
    );
  }

  @override
  Future<void> scheduleOnce({
    required int id,
    required String title,
    required String body,
    required DateTime scheduledDate,
    String? payload,
  }) async {
    final now = DateTime.now();

    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }

    if (!scheduledDate.isBefore(now)) {
      await _notificationsPlugin.zonedSchedule(
        id,
        title,
        body,
        tz.TZDateTime.from(scheduledDate, tz.local),
        _notificationDetails(),
        payload: payload,
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
      );
    }
  }

  @override
  Future<void> scheduleDaily({
    required int id,
    required String title,
    required String body,
    required DateTime scheduledDate,
    String? payload,
  }) async {
    final now = DateTime.now();
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }

    await _notificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.from(scheduledDate, tz.local),
      _notificationDetails(),
      payload: payload,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  @override
  Future<void> scheduleWeekly({
    required int id,
    required String title,
    required String body,
    required int day,
    required TimeOfDay time,
    String? payload,
  }) async {
    var scheduledDate = _nextInstanceOfDayAndTime(day, time);

    await _notificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.from(scheduledDate, tz.local),
      _notificationDetails(),
      payload: payload,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime,
    );
  }

  DateTime _nextInstanceOfDayAndTime(int day, TimeOfDay time) {
    final now = DateTime.now();
    var scheduledDate = DateTime(
      now.year,
      now.month,
      now.day,
      time.hour,
      time.minute,
    );

    while (scheduledDate.weekday != day) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }

    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 7));
    }

    return scheduledDate;
  }

  @override
  Future<void> scheduleMedicineNotifications(
    MedicineObjectBoxModel medicine,
  ) async {
    await cancelMedicineNotifications(medicine);

    final now = DateTime.now();
    if (medicine.endDate != null && medicine.endDate!.isBefore(now)) return;

    final freq = ScheduleFrequency.values.firstWhere(
      (e) => e.name == medicine.frequency,
      orElse: () => ScheduleFrequency.once,
    );

    for (var doseTime in medicine.doseTimes) {
      switch (freq) {
        case ScheduleFrequency.once:
          final scheduledDate = DateTime(
            medicine.startDate.year,
            medicine.startDate.month,
            medicine.startDate.day,
            doseTime.hour,
            doseTime.minute,
          );
          await scheduleOnce(
            id: generateId(
              medicineId: medicine.id,
              hour: doseTime.hour,
              minute: doseTime.minute,
            ),
            title: 'Medication Reminder',
            body: 'Time to take ${medicine.name}',
            scheduledDate: scheduledDate,
            payload: medicine.id,
          );
          break;

        case ScheduleFrequency.daily:
          final scheduledDate = DateTime(
            now.year,
            now.month,
            now.day,
            doseTime.hour,
            doseTime.minute,
          );
          await scheduleDaily(
            id: generateId(
              medicineId: medicine.id,
              hour: doseTime.hour,
              minute: doseTime.minute,
            ),
            title: 'Medication Reminder',
            body: 'Time to take ${medicine.name}',
            scheduledDate: scheduledDate,
            payload: medicine.id,
          );
          break;

        case ScheduleFrequency.weekly:
          for (var day in medicine.selectedWeeklyDaysInts) {
            await scheduleWeekly(
              id: generateId(
                medicineId: medicine.id,
                day: day,
                hour: doseTime.hour,
                minute: doseTime.minute,
              ),
              title: 'Medication Reminder',
              body: 'Time to take ${medicine.name}',
              time: doseTime,
              day: day,
              payload: medicine.id,
            );
          }
          break;

        case ScheduleFrequency.custom:
          if (medicine.customInterval == null) break;
          for (int i = 0; i < 3; i++) {
            final date = medicine.startDate.add(
              Duration(days: i * medicine.customInterval!),
            );
            if (medicine.endDate != null && date.isAfter(medicine.endDate!)) {
              break;
            }

            final scheduledDate = DateTime(
              date.year,
              date.month,
              date.day,
              doseTime.hour,
              doseTime.minute,
            );
            await scheduleOnce(
              id: generateId(
                medicineId: medicine.id,
                day: scheduledDate.day,
                month: scheduledDate.month,
                hour: doseTime.hour,
                minute: doseTime.minute,
              ),
              title: 'Medication Reminder',
              body: 'Time to take ${medicine.name}',
              scheduledDate: scheduledDate,
              payload: medicine.id,
            );
          }
          break;
      }
    }
  }

  @override
  int generateId({
    required String medicineId,
    required int hour,
    required int minute,
    int month = 0,
    int day = 0,
  }) {
    final hrStr = hour.toString().padLeft(2, '0');
    final minStr = minute.toString().padLeft(2, '0');
    final monthStr = month.toString().padLeft(2, '0');
    final dayStr = day.toString().padLeft(2, '0');
    final uniqueId = '$medicineId$monthStr$dayStr$hrStr$minStr';
    return uniqueId.hashCode.abs() % 2147483647; // 32 bits for android
  }

  @override
  Future<void> cancelNotification(int id) async {
    await _notificationsPlugin.cancel(id);
  }

  @override
  Future<void> cancelMedicineNotifications(
    MedicineObjectBoxModel medicine,
  ) async {
    final freq = ScheduleFrequency.values.firstWhere(
      (e) => e.name == medicine.frequency,
      orElse: () => ScheduleFrequency.once,
    );

    for (var doseTime in medicine.doseTimes) {
      switch (freq) {
        case ScheduleFrequency.once:
          await cancelNotification(
            generateId(
              medicineId: medicine.id,
              hour: doseTime.hour,
              minute: doseTime.minute,
            ),
          );
          break;
        case ScheduleFrequency.daily:
          await cancelNotification(
            generateId(
              medicineId: medicine.id,
              hour: doseTime.hour,
              minute: doseTime.minute,
            ),
          );
          break;
        case ScheduleFrequency.weekly:
          for (var day in medicine.selectedWeeklyDaysInts) {
            await cancelNotification(
              generateId(
                medicineId: medicine.id,
                day: day,
                hour: doseTime.hour,
                minute: doseTime.minute,
              ),
            );
          }
          break;
        case ScheduleFrequency.custom:
          final now = DateTime.now();
          final todayAtMidnight = DateTime(now.year, now.month, now.day);
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
            final checkDate = startCheck.add(Duration(days: i * interval));
            await cancelNotification(
              generateId(
                medicineId: medicine.id,
                month: checkDate.month,
                day: checkDate.day,
                hour: doseTime.hour,
                minute: doseTime.minute,
              ),
            );
          }
          break;
      }
    }
  }

  @override
  Future<void> cancelAll() async {
    await _notificationsPlugin.cancelAll();
  }
}
