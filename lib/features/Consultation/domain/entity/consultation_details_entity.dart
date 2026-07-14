class ConsultationDetailsEntity {
  final String consultationId;
  final String slotId;
  final DateTime startTime;
  final int durationInMinutes;
  final num rate;
  final int reviewCount;
  final String status;
  final double price;
  final DoctorEntity doctor;
  final DateTime bookedAt;
  final DateTime? cancelledAt;
  final String? reason;
  final bool cancelByPatient;
  final String notes;

  ConsultationDetailsEntity({
    required this.consultationId,
    required this.slotId,
    required this.startTime,
    required this.durationInMinutes,
    required this.rate,
    required this.reviewCount,
    required this.status,
    required this.price,
    required this.doctor,
    required this.bookedAt,
    this.cancelledAt,
    this.reason,
    required this.cancelByPatient,
    required this.notes,
  });
}

class DoctorEntity {
  final String id;
  final String firstName;
  final String lastName;
  final String specialization;

  DoctorEntity({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.specialization,
  });
}
