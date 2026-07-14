import 'package:rafiq/features/Consultation/domain/entity/consultation_details_entity.dart';

class ConsultationDetailsModel {
  final String consultationId;
  final String slotId;
  final DateTime startTime;
  final int durationInMinutes;
  final num rate;
  final int reviewCount;
  final String status;
  final double price;
  final DoctorModel doctor;
  final DateTime bookedAt;
  final DateTime? cancelledAt;
  final String? reason;
  final bool cancelByPatient;
  final String notes;

  ConsultationDetailsModel({
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

  factory ConsultationDetailsModel.fromJson(Map<String, dynamic> json) {
    return ConsultationDetailsModel(
      consultationId: json['consultationId'] as String,
      slotId: json['slotId'] as String,
      startTime: DateTime.parse(json['startTime']),
      durationInMinutes: json['durationInMinutes'] as int,
      rate: json['rate'] as num,
      reviewCount: json['reviewCount'] as int,
      status: json['status'] as String,
      price: (json['price'] as num).toDouble(),
      doctor: DoctorModel.fromJson(json['doctor'] as Map<String, dynamic>),
      bookedAt: DateTime.parse(json['bookedAt']),
      cancelledAt: json['cancelledAt'] != null
          ? DateTime.parse(json['cancelledAt'])
          : null,
      reason: json['reason'] as String?,
      cancelByPatient: json['cancelByPatient'] as bool,
      notes: json['notes'] as String,
    );
  }

  ConsultationDetailsEntity toEntity() {
    return ConsultationDetailsEntity(
      consultationId: consultationId,
      slotId: slotId,
      startTime: startTime,
      durationInMinutes: durationInMinutes,
      rate: rate,
      reviewCount: reviewCount,
      status: status,
      price: price,
      doctor: doctor.toEntity(),
      bookedAt: bookedAt,
      cancelByPatient: cancelByPatient,
      notes: notes,
    );
  }
}

class DoctorModel {
  final String id;
  final String firstName;
  final String lastName;
  final String specialization;

  DoctorModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.specialization,
  });

  factory DoctorModel.fromJson(Map<String, dynamic> json) {
    return DoctorModel(
      id: json['id'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      specialization: json['specialization'] as String,
    );
  }

  DoctorEntity toEntity() {
    return DoctorEntity(
      id: id,
      firstName: firstName,
      lastName: lastName,
      specialization: specialization,
    );
  }
}
