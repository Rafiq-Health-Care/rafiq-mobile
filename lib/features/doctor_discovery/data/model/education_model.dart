import 'package:rafiq/features/doctor_discovery/domain/entity/education_entity.dart';

class EducationModel {
  final String id;
  final String degree;
  final String university;
  final DateTime startYear;
  final DateTime endYear;

  const EducationModel({
    required this.id,
    required this.degree,
    required this.university,
    required this.startYear,
    required this.endYear,
  });

  factory EducationModel.fromJson(Map<String, dynamic> json) {
    return EducationModel(
      id: json['id'] ?? '',
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

  EducationEntity toEntity() {
    return EducationEntity(
      id: id,
      degree: degree,
      university: university,
      startYear: startYear,
      endYear: endYear,
    );
  }
}
