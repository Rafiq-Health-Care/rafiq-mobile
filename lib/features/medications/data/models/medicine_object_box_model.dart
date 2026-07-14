import 'package:flutter/material.dart';
import 'package:rafiq/features/medications/data/enums/medicine_status_enum.dart';
import 'package:rafiq/features/medications/data/enums/medicine_type_enum.dart';
import 'package:rafiq/features/medications/data/models/medicines_details_model.dart';
import 'package:rafiq/features/medications/presentation/enums/week_days.dart';

class MedicineObjectBoxModel {
  int objectBoxID;

  final String id; // from API (String in existing models)
  final String name;
  final String dosage;
  final DateTime startDate;
  final DateTime? endDate;
  final String? type;
  final String status;
  final String? notes;

  // ObjectBox doesn't support List<TimeOfDay> or List<Enum>
  // We'll store TimeOfDay as a list of strings "HH:mm"
  final List<String> doseTimesStrings;

  final String frequency;

  // Storing WeekDays as List<int> as requested
  final List<int> selectedWeeklyDaysInts;

  final int? customInterval;

  MedicineObjectBoxModel({
    this.objectBoxID = 0,
    required this.id,
    required this.name,
    required this.dosage,
    required this.startDate,
    this.endDate,
    this.type,
    required this.status,
    this.notes,
    required this.doseTimesStrings,
    required this.frequency,
    this.selectedWeeklyDaysInts = const [],
    this.customInterval,
  });

  MedicinesDetailsModel toMedicinesDetailsModel() {
    return MedicinesDetailsModel(
      id: id,
      patientId: 'unknown',
      name: name,
      dosage: dosage,
      frequency: frequency,
      reminderFrequency: frequency,
      startDate: startDate,
      customDays: [],
      endDate: endDate,
      notes: notes,
      type: type != null
          ? MedicineTypeEnum.values.firstWhere((e) => e.name == type)
          : null,
      status: MedicineStatusEnum.values.firstWhere((e) => e.name == status),
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
  }

  // Helper to convert to/from TimeOfDay
  List<TimeOfDay> get doseTimes {
    return doseTimesStrings.map((t) {
      final parts = t.split(':');
      return TimeOfDay(hour: int.parse(parts[0]), minute: int.parse(parts[1]));
    }).toList();
  }

  // Helper to convert to/from WeekDays
  List<WeekDays> get selectedWeeklyDays {
    return selectedWeeklyDaysInts.map((i) {
      return WeekDays.values.firstWhere((d) => d.dayNumber == i);
    }).toList();
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'dosage': dosage,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate?.toIso8601String(),
      'type': type,
      'notes': notes,
      'doseTimesStrings': doseTimesStrings,
      'frequency': frequency,
      'selectedWeeklyDaysInts': selectedWeeklyDaysInts,
      'customInterval': customInterval,
    };
  }

  factory MedicineObjectBoxModel.fromJson(
    Map<String, dynamic> json, {
    required int objectBoxID,
    required String id,
    required String status,
  }) {
    return MedicineObjectBoxModel(
      objectBoxID: objectBoxID,
      id: id,
      name: json['name'] as String,
      dosage: json['dosage'] as String,
      startDate: DateTime.parse(json['startDate'] as String),
      endDate: json['endDate'] != null ? DateTime.parse(json['endDate'] as String) : null,
      type: json['type'] as String?,
      status: status,
      notes: json['notes'] as String?,
      doseTimesStrings: List<String>.from(json['doseTimesStrings'] as List),
      frequency: json['frequency'] as String,
      selectedWeeklyDaysInts: List<int>.from(json['selectedWeeklyDaysInts'] as List),
      customInterval: json['customInterval'] as int?,
    );
  }

  @override
  String toString() {
    return 'MedicineObjectBoxModel(objectBoxID: $objectBoxID, id: $id, name: $name, dosage: $dosage, startDate: $startDate, endDate: $endDate, type: $type, status: $status, notes: $notes, doseTimesStrings: $doseTimesStrings, frequency: $frequency, selectedWeeklyDaysInts: $selectedWeeklyDaysInts, customInterval: $customInterval)';
  }
}
