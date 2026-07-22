import 'package:rafiq/features/doctor_discovery/domain/entity/experience_entity.dart';

class ExperienceModel {
  final String id;
  final String position;
  final String hospital;
  final DateTime startDate;
  final DateTime endDate;
  final String description;
  final bool current;

  const ExperienceModel({
    required this.id,
    required this.position,
    required this.hospital,
    required this.startDate,
    required this.endDate,
    required this.description,
    required this.current,
  });

  factory ExperienceModel.fromJson(Map<String, dynamic> json) {
    return ExperienceModel(
      id: json['id'] ?? '',
      position: json['position'] ?? '',
      hospital: json['hospital'] ?? '',
      startDate: json['startDate'] != null
          ? DateTime.parse(json['startDate'].toString())
          : DateTime.now(),
      endDate: json['endDate'] != null
          ? DateTime.parse(json['endDate'].toString())
          : DateTime.now(),
      description: json['description'] ?? '',
      current: json['current'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'position': position,
      'hospital': hospital,
      'startDate': startDate,
      'endDate': endDate,
      'description': description,
      'current': current,
    };
  }

  ExperienceEntity toEntity() {
    return ExperienceEntity(
      id: id,
      position: position,
      hospital: hospital,
      startDate: startDate,
      endDate: endDate,
      description: description,
      current: current,
    );
  }
}
