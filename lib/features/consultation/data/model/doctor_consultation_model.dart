import 'package:rafiq/features/consultation/data/model/patient_model.dart';
import 'package:rafiq/features/consultation/domain/entity/doctor_consultation_entity.dart';
import 'package:rafiq/features/consultation/domain/enum/consultation_status.dart';

class DoctorConsultationModel {
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

  const DoctorConsultationModel({
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

  factory DoctorConsultationModel.fromJson(Map<String, dynamic> json) {
    return DoctorConsultationModel(
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

  DoctorConsultationEntity toEntity() {
    return DoctorConsultationEntity(
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
