import 'package:equatable/equatable.dart';
import 'package:rafiq/features/consultation/domain/entity/patient_entity.dart';
import 'package:rafiq/features/consultation/domain/enum/consultation_status.dart';

/// The doctor's view of a consultation — as opposed to `ConsultationEntity`
/// / `ConsultationDetailsEntity`, which are the patient's view of the same
/// underlying resource. Kept as separate types since the two roles see
/// different fields (this one carries patient info + cancellation/notes
/// controls; the patient-facing ones carry doctor info instead).
class DoctorConsultationEntity extends Equatable {
  final String consultationId;
  final String slotId;
  final DateTime startTime;
  final DateTime endTime;
  final ConsultationStatus status;
  final PatientEntity patient;
  final DateTime bookedAt;
  final DateTime? cancelledAt;
  final String? reason;
  final bool cancelByPatient;
  final String notes;

  const DoctorConsultationEntity({
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

  bool get isCancelled => status == ConsultationStatus.cancelled;
  bool get hasNotes => notes.trim().isNotEmpty;
  bool get hasCancellationReason => (reason ?? '').trim().isNotEmpty;

  /// Doctors can only cancel sessions that haven't already been
  /// cancelled or completed.
  bool get isCancellable =>
      status == ConsultationStatus.upcoming ||
      status == ConsultationStatus.pending;

  DoctorConsultationEntity copyWith({
    ConsultationStatus? status,
    DateTime? cancelledAt,
    String? reason,
    bool? cancelByPatient,
  }) {
    return DoctorConsultationEntity(
      consultationId: consultationId,
      slotId: slotId,
      startTime: startTime,
      endTime: endTime,
      status: status ?? this.status,
      patient: patient,
      bookedAt: bookedAt,
      cancelledAt: cancelledAt ?? this.cancelledAt,
      reason: reason ?? this.reason,
      cancelByPatient: cancelByPatient ?? this.cancelByPatient,
      notes: notes,
    );
  }

  @override
  List<Object?> get props => [
    consultationId,
    slotId,
    startTime,
    endTime,
    status,
    patient,
    bookedAt,
    cancelledAt,
    reason,
    cancelByPatient,
    notes,
  ];
}
