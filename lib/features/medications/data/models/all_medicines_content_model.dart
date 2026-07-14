import 'package:equatable/equatable.dart';
import 'package:rafiq/features/medications/data/enums/medicine_status_enum.dart';

class AllMedicinesContentModel extends Equatable {
  final String id;
  final String name;
  final String dosage;
  final String frequency;
  final String reminderFrequency;
  final List<String> customDays;
  final MedicineStatusEnum status;
  final DateTime? nextReminder;
  final String? groupId;
  final String? groupName;
  final String? groupColor;

  const AllMedicinesContentModel({
    required this.id,
    required this.name,
    required this.dosage,
    required this.frequency,
    required this.reminderFrequency,
    required this.customDays,
    required this.status,
    required this.nextReminder,
    required this.groupId,
    required this.groupName,
    required this.groupColor,
  });

  factory AllMedicinesContentModel.fromJson(Map<String, dynamic> json) {
    return AllMedicinesContentModel(
      id: json['id'],
      name: json['name'],
      dosage: json['dosage'],
      frequency: json['frequency'],
      reminderFrequency: json['reminderFrequency'],
      customDays: List<String>.from(json['customDays']),
      status: MedicineStatusEnum.fromJson(json['status']),
      nextReminder: json['nextReminder'] != null
          ? DateTime.tryParse(json['nextReminder'])
          : null,
      groupId: json['groupId'],
      groupName: json['groupName'],
      groupColor: json['groupColor'],
    );
  }

  @override
  List<Object?> get props => [
    id,
    name,
    dosage,
    frequency,
    reminderFrequency,
    customDays,
    status,
    nextReminder,
    groupId,
    groupName,
    groupColor,
  ];
}
