class ConsultationEntity {
  final String consultationId;
  final String doctorName;
  final String doctorBio;
  final String doctorImage;
  final DateTime startTime;
  final int duration;
  final String summaryId;
  final String doctorId;

  ConsultationEntity({
    required this.consultationId,
    required this.doctorName,
    required this.doctorBio,
    required this.doctorImage,
    required this.startTime,
    required this.duration,
    required this.summaryId,
    required this.doctorId,
  });
}
