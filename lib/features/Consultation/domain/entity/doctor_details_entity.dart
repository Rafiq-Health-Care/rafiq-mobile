class EducationEntity {
  final String degree;
  final String university;
  final DateTime startYear;
  final DateTime endYear;

  const EducationEntity({
    required this.degree,
    required this.university,
    required this.startYear,
    required this.endYear,
  });
}

class ExperienceEntity {
  final String position;
  final String hospital;
  final DateTime startYear;
  final DateTime endYear;
  final String description;

  const ExperienceEntity({
    required this.position,
    required this.hospital,
    required this.startYear,
    required this.endYear,
    required this.description,
  });
}

class DoctorDetailsEntity {
  final String id;
  final String name;
  final String personalPhoto;
  final String biography;
  final String description;
  final double price;
  final String specialization;
  final List<EducationEntity> education;
  final List<ExperienceEntity> experience;

  const DoctorDetailsEntity({
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
}
