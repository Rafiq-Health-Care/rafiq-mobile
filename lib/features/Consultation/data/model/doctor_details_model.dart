import 'package:rafiq/features/Consultation/domain/entity/doctor_details_entity.dart';

class EducationModel {
  final String degree;
  final String university;
  final DateTime startYear;
  final DateTime endYear;

  const EducationModel({
    required this.degree,
    required this.university,
    required this.startYear,
    required this.endYear,
  });

  factory EducationModel.fromJson(Map<String, dynamic> json) {
    return EducationModel(
      degree: json['degree'] ?? '',
      university: json['university'] ?? '',
      startYear: json['startDate'] != null
          ? DateTime.parse(json['startDate'].toString())
          : DateTime.now(),
      endYear: json['endDate'] != null
          ? DateTime.parse(json['endDate'].toString())
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'degree': degree,
      'university': university,
      'startYear': startYear,
      'endYear': endYear,
    };
  }

  EducationEntity toEntity() {
    return EducationEntity(
      degree: degree,
      university: university,
      startYear: startYear,
      endYear: endYear,
    );
  }
}

class ExperienceModel {
  final String position;
  final String hospital;
  final DateTime startYear;
  final DateTime endYear;
  final String description;

  const ExperienceModel({
    required this.position,
    required this.hospital,
    required this.startYear,
    required this.endYear,
    required this.description,
  });

  factory ExperienceModel.fromJson(Map<String, dynamic> json) {
    return ExperienceModel(
      position: json['position'] ?? '',
      hospital: json['hospital'] ?? '',
      startYear: json['startDate'] != null
          ? DateTime.parse(json['startDate'].toString())
          : DateTime.now(),
      endYear: json['endDate'] != null
          ? DateTime.parse(json['endDate'].toString())
          : DateTime.now(),
      description: json['description'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'position': position,
      'hospital': hospital,
      'startYear': startYear,
      'endYear': endYear,
      'description': description,
    };
  }

  ExperienceEntity toEntity() {
    return ExperienceEntity(
      position: position,
      hospital: hospital,
      startYear: startYear,
      endYear: endYear,
      description: description,
    );
  }
}

class DoctorDetailsModel {
  final String id;
  final String name;
  final String personalPhoto;
  final String biography;
  final String description;
  final double price;
  final String specialization;
  final List<EducationModel> education;
  final List<ExperienceModel> experience;

  const DoctorDetailsModel({
    required this.id,
    required this.name,
    required this.personalPhoto,
    required this.biography,
    required this.description,
    required this.price,
    required this.specialization,
    required this.education,
    required this.experience,
  });

  factory DoctorDetailsModel.fromJson(Map<String, dynamic> json) {
    return DoctorDetailsModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      personalPhoto: json['personalPhoto'] ?? '',
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
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'personalPhoto': personalPhoto,
      'biography': biography,
      'description': description,
      'price': price,
      'specialization': specialization,
      'education': education.map((e) => e.toJson()).toList(),
      'experience': experience.map((e) => e.toJson()).toList(),
    };
  }

  DoctorDetailsEntity toEntity() {
    return DoctorDetailsEntity(
      id: id,
      name: name,
      personalPhoto: personalPhoto,
      biography: biography,
      description: description,
      price: price,
      specialization: specialization,
      education: education.map((e) => e.toEntity()).toList(),
      experience: experience.map((e) => e.toEntity()).toList(),
    );
  }
}
