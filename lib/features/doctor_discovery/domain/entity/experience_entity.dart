class ExperienceEntity {
  final String id;
  final String position;
  final String hospital;
  final DateTime startDate;
  final DateTime endDate;
  final String description;
  final bool current;

  const ExperienceEntity({
    required this.id,
    required this.position,
    required this.hospital,
    required this.startDate,
    required this.endDate,
    required this.description,
    required this.current,
  });
}