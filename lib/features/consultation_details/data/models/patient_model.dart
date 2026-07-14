import 'package:rafiq/features/consultation_details/domain/entities/patient.dart';

class PatientModel {
  final String id;
  final String firstName;
  final String lastName;

  const PatientModel({
    required this.id,
    required this.firstName,
    required this.lastName,
  });

  factory PatientModel.fromJson(Map<String, dynamic> json) {
    return PatientModel(
      id: json['id'] as String? ?? '',
      firstName: json['firstName'] as String? ?? '',
      lastName: json['lastName'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'firstName': firstName,
    'lastName': lastName,
  };

  Patient toEntity() {
    return Patient(id: id, firstName: firstName, lastName: lastName);
  }
}
