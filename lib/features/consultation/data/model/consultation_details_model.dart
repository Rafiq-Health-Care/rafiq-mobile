import 'package:rafiq/features/consultation/domain/entity/consultation_details_entity.dart';

class ConsultationDetailsModel {
  final String consultationId;
  final String slotId;
  final DateTime startTime;
  final int durationInMinutes;
  final num rate;
  final int reviewCount;
  final String status;
  final double price;
  final ConsultationDoctorModel doctor;
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
      doctor: ConsultationDoctorModel.fromJson(
        json['doctor'] as Map<String, dynamic>,
      ),
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

/// Minimal doctor summary as returned by the consultation-details endpoint.
/// Separate from `doctor_discovery`'s `DoctorModel` on purpose — see
/// `ConsultationDoctorEntity` for why.
class ConsultationDoctorModel {
  final String id;
  final String firstName;
  final String lastName;
  final String specialization;

  ConsultationDoctorModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.specialization,
  });

  factory ConsultationDoctorModel.fromJson(Map<String, dynamic> json) {
    return ConsultationDoctorModel(
      id: json['id'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      specialization: json['specialization'] as String,
    );
  }

  ConsultationDoctorEntity toEntity() {
    return ConsultationDoctorEntity(
      id: id,
      firstName: firstName,
      lastName: lastName,
      specialization: specialization,
    );
  }
}
