import 'package:rafiq/features/medications/data/enums/medicine_type_enum.dart';

class MedicinesDetailsRequest {
  final String medicineId;
  final String dosage;
  final String frequency;
  final String reminderFrequency;
  final DateTime startDate;
  final List<String>? customDays;
  final DateTime? endDate;
  final String? notes;
  final MedicineTypeEnum type;

  const MedicinesDetailsRequest({
    required this.medicineId,
    required this.dosage,
    required this.frequency,
    required this.reminderFrequency,
    required this.startDate,
    this.customDays,
    this.endDate,
    this.notes,
    this.type = MedicineTypeEnum.other,
  });

  Map<String, dynamic> toJson() {
    return {
      'medicineId': medicineId,
      'dosage': dosage,
      'frequency': frequency,
      'reminderFrequency': reminderFrequency,
      'customDays': customDays,
      'startDate': startDate.toUtc().toIso8601String(),
      'endDate': endDate?.toUtc().toIso8601String(),
      'notes': notes,
      'type': type.typeStr(),
    };
  }
}
