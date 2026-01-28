import 'package:equatable/equatable.dart';
import 'package:rafiq/features/medications/data/enums/medicine_status_enum.dart';
import 'package:rafiq/features/medications/data/enums/medicine_type_enum.dart';

class MedicinesDetailsModel extends Equatable {
  final String id;
  final String patientId;
  final String name;
  final String dosage;
  final String frequency;
  final String reminderFrequency;
  final DateTime startDate;
  final List<String>? customDays;
  final DateTime? endDate;
  final String? notes;
  final MedicineTypeEnum? type;
  final String? photoUrl;
  final MedicineStatusEnum status;
  final String? groupId;
  final String? groupName;
  final String? reminderId;
  final String? nextReminder;
  final DateTime createdAt;
  final DateTime updatedAt;

  const MedicinesDetailsModel({
    required this.id,
    required this.patientId,
    required this.name,
    required this.dosage,
    required this.frequency,
    required this.reminderFrequency,
    required this.startDate,
    this.customDays,
    this.endDate,
    this.notes,
    this.type,
    this.photoUrl,
    required this.status,
    this.groupId,
    this.groupName,
    this.reminderId,
    this.nextReminder,
    required this.createdAt,
    required this.updatedAt,
  });

  factory MedicinesDetailsModel.fromJson(Map<String, dynamic> json) {
    return MedicinesDetailsModel(
      id: json['id'],
      patientId: json['patientId'],
      name: json['name'],
      dosage: json['dosage'],
      frequency: json['frequency'],
      reminderFrequency: json['reminderFrequency'],
      startDate: DateTime.parse(json['startDate']),
      customDays: List<String>.from(json['customDays'] ?? []),
      endDate: json['endDate'] == null ? null : DateTime.parse(json['endDate']),
      notes: json['notes'],
      type: MedicineTypeEnum.fromJson(json['type']),
      photoUrl: json['photoUrl'],
      status: MedicineStatusEnum.fromJson(json['status']),
      groupId: json['groupId'],
      groupName: json['groupName'],
      reminderId: json['reminderId'],
      nextReminder: json['nextReminder'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  @override
  List<Object?> get props => [
    id,
    patientId,
    name,
    dosage,
    frequency,
    reminderFrequency,
    startDate,
    customDays,
    endDate,
    notes,
    type,
    photoUrl,
    status,
    groupId,
    groupName,
    reminderId,
    nextReminder,
    createdAt,
    updatedAt,
  ];
}
