import 'package:flutter/material.dart';
import 'package:rafiq/features/medications/data/models/medicine_object_box_model.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

abstract class INotificationService {
  Future<void> initialize();
  Future<void> scheduleOnce({
    required int id,
    required String title,
    required String body,
    required DateTime scheduledDate,
    String? payload,
  });
  Future<void> scheduleDaily({
    required int id,
    required String title,
    required String body,
    required DateTime scheduledDate,
    String? payload,
  });
  Future<void> scheduleWeekly({
    required int id,
    required String title,
    required String body,
    required int day,
    required TimeOfDay time,
    String? payload,
  });
  Future<void> scheduleMedicineNotifications(MedicineObjectBoxModel medicine);
  Future<void> cancelNotification(int id);
  Future<void> cancelMedicineNotifications(MedicineObjectBoxModel medicine);
  Future<void> cancelAll();
  int generateId({
    required String medicineId,
    required int hour,
    required int minute,
    int month = 0,
    int day = 0,
  });
  Future<NotificationAppLaunchDetails?> getNotificationAppLaunchDetails();
}
