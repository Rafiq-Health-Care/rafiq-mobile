import 'package:rafiq/features/doctor_discovery/domain/entity/education_entity.dart';
import 'package:rafiq/features/doctor_discovery/domain/entity/experience_entity.dart';

class DoctorDetailsEntity {
  final String id;
  final String firstName;
  final String lastName;
  final String personalPhoto;
  final String biography;
  final String description;
  final double price;
  final String specialization;
  final List<EducationEntity> education;
  final List<ExperienceEntity> experience;
  final DateTime nextAvailable;
  final int consultationCount;
  final double rating;
  final int yearsOfExperience;

  const DoctorDetailsEntity({
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
}
