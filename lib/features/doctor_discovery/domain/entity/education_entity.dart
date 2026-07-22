class EducationEntity {
  final String id;
  final String degree;
  final String university;
  final DateTime startYear;
  final DateTime endYear;

  const EducationEntity({
    required this.id,
    required this.degree,
    required this.university,
    required this.startYear,
    required this.endYear,
  });
}
