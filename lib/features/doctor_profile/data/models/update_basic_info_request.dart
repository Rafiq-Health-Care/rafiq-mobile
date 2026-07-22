/// Body for `PUT /api/v1/doctor/basicInfo`.
/// This call *replaces* the doctor's basic info, so every field is sent
/// even if unchanged.
class UpdateBasicInfoRequest {
  final String firstName;
  final String lastName;
  final String specialization;
  final List<String> subSpecializations;
  final List<String> languages;
  final String description;
  final int yearsOfExperience;

  const UpdateBasicInfoRequest({
    required this.firstName,
    required this.lastName,
    required this.specialization,
    required this.subSpecializations,
    required this.languages,
    required this.description,
    required this.yearsOfExperience,
  });

  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'specialization': specialization,
      'subSpecializations': subSpecializations,
      'languages': languages,
      'description': description,
      'yearsOfExperience': yearsOfExperience,
    };
  }
}
