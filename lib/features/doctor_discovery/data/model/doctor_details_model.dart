import 'package:rafiq/features/doctor_discovery/data/model/education_model.dart';
import 'package:rafiq/features/doctor_discovery/data/model/experience_model.dart';
import 'package:rafiq/features/doctor_discovery/domain/entity/doctor_details_entity.dart';

class DoctorDetailsModel {
  final String id;
  final String firstName;
  final String lastName;
  final String personalPhoto;
  final String biography;
  final String description;
  final double price;
  final String specialization;
  final List<EducationModel> education;
  final List<ExperienceModel> experience;
  final DateTime nextAvailable;
  final int consultationCount;
  final double rating;
  final int yearsOfExperience;

  const DoctorDetailsModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.personalPhoto,
    required this.biography,
    required this.description,
    required this.price,
    required this.specialization,
    required this.education,
    required this.experience,
    required this.nextAvailable,
    required this.consultationCount,
    required this.rating,
    required this.yearsOfExperience,
  });

  factory DoctorDetailsModel.fromJson(Map<String, dynamic> json) {
    return DoctorDetailsModel(
      id: json['id'] ?? '',
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      personalPhoto:
          json['personalPhoto'] ?? 'https://i.postimg.cc/2ycZ7LrZ/ahmed.png',
      biography: json['biography'] ?? '',
      description: json['description'] ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      specialization: json['specialization'] ?? '',
      education:
          (json['education'] as List?)
              ?.map((e) => EducationModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      experience:
          (json['experience'] as List?)
              ?.map((e) => ExperienceModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      nextAvailable: json['nextAvailable'] != null
          ? DateTime.parse(json['nextAvailable'].toString())
          : DateTime.now(),
      consultationCount: json['consultationCount'] ?? 0,
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      yearsOfExperience: json['yearsOfExperience'] ?? 0,
    );
  }

  DoctorDetailsEntity toEntity() {
    return DoctorDetailsEntity(
      id: id,
      personalPhoto: personalPhoto,
      biography: biography,
      description: description,
      price: price,
      specialization: specialization,
      education: education.map((e) => e.toEntity()).toList(),
      experience: experience.map((e) => e.toEntity()).toList(),
      firstName: firstName,
      lastName: lastName,
      nextAvailable: nextAvailable,
      consultationCount: consultationCount,
      rating: rating,
      yearsOfExperience: yearsOfExperience,
    );
  }
}
