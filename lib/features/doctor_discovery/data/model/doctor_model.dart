import 'package:rafiq/features/doctor_discovery/domain/entity/doctor_entity.dart';

class DoctorModel {
  final String doctorId;
  final String firstName;
  final String lastName;
  final String specialization;
  final String personalPhoto;
  final DateTime nextAvailable;
  final double price;
  final double rating;
  final int yearsOfExperience;

  DoctorModel({
    required this.doctorId,
    required this.firstName,
    required this.lastName,
    required this.specialization,
    required this.personalPhoto,
    required this.nextAvailable,
    required this.price,
    required this.rating,
    required this.yearsOfExperience,
  });

  factory DoctorModel.fromJson(Map<String, dynamic> json) {
    return DoctorModel(
      doctorId: json['doctorId'] ?? '',
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      specialization: json['specialization'] ?? '',
      personalPhoto: json['personalPhoto'] ?? "https://i.postimg.cc/2ycZ7LrZ/ahmed.png",
      nextAvailable: DateTime.parse(json['nextAvailable']),
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      yearsOfExperience: json['yearsOfExperience'] as int? ?? 0,
    );
  }

  DoctorEntity toEntity() {
    return DoctorEntity(
      doctorId: doctorId,
      firstName: firstName,
      lastName: lastName,
      specialization: specialization,
      personalPhoto: personalPhoto,
      nextAvailable: nextAvailable,
      price: price,
      rating: rating,
      yearsOfExperience: yearsOfExperience,
    );
  }
}
