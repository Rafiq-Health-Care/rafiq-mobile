import 'package:rafiq/features/consultation_details/domain/entities/consultation.dart';

import 'patient_model.dart';

class ConsultationModel {
  final String consultationId;
  final String slotId;
  final DateTime startTime;
  final DateTime endTime;
  final ConsultationStatus status;
  final PatientModel patient;
  final DateTime bookedAt;
  final DateTime? cancelledAt;
  final String? reason;
  final bool cancelByPatient;
  final String notes;

  const ConsultationModel({
    required this.consultationId,
    required this.slotId,
    required this.startTime,
    required this.endTime,
    required this.status,
    required this.patient,
    required this.bookedAt,
    this.cancelledAt,
    this.reason,
    required this.cancelByPatient,
    required this.notes,
  });

  factory ConsultationModel.fromJson(Map<String, dynamic> json) {
    return ConsultationModel(
      consultationId: json['consultationId'] as String? ?? '',
      slotId: json['slotId'] as String? ?? '',
      startTime: DateTime.parse(json['startTime'] as String),
      endTime: DateTime.parse(json['endTime'] as String),
      status: ConsultationStatusX.fromApi(json['status'] as String? ?? ''),
      patient: PatientModel.fromJson(
        json['patient'] as Map<String, dynamic>? ?? const {},
      ),
      bookedAt: DateTime.parse(json['bookedAt'] as String),
      cancelledAt: json['cancelledAt'] != null
          ? DateTime.tryParse(json['cancelledAt'] as String)
          : null,
      reason: json['reason'] as String?,
      cancelByPatient: json['cancelByPatient'] as bool? ?? false,
      notes: json['notes'] as String? ?? '',
    );
  }

  Consultation toEntity() {
    return Consultation(
      consultationId: consultationId,
      slotId: slotId,
      startTime: startTime,
      endTime: endTime,
      status: status,
      patient: patient.toEntity(),
      bookedAt: bookedAt,
      cancelByPatient: cancelByPatient,
      notes: notes,
    );
  }
}
