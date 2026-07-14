import 'package:equatable/equatable.dart';
import 'patient.dart';

enum ConsultationStatus { pending, completed, cancelled, upcoming, live }

extension ConsultationStatusX on ConsultationStatus {
  static ConsultationStatus fromApi(String raw) {
    return ConsultationStatus.values.firstWhere(
      (e) => e.name.toUpperCase() == raw.toUpperCase(),
      orElse: () => ConsultationStatus.pending,
    );
  }
}

class Consultation extends Equatable {
  final String consultationId;
  final String slotId;
  final DateTime startTime;
  final DateTime endTime;
  final ConsultationStatus status;
  final Patient patient;
  final DateTime bookedAt;
  final DateTime? cancelledAt;
  final String? reason;
  final bool cancelByPatient;
  final String notes;

  const Consultation({
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
      status == ConsultationStatus.upcoming || status == ConsultationStatus.pending;

  Consultation copyWith({
    ConsultationStatus? status,
    DateTime? cancelledAt,
    String? reason,
    bool? cancelByPatient,
  }) {
    return Consultation(
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
