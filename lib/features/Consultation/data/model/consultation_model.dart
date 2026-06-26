import 'package:rafiq/features/Consultation/domain/entity/consultation_entity.dart';

class ConsultationModel {
  final String consultationId;
  final String doctorName;
  final String doctorBio;
  final String doctorImage;
  final DateTime startTime;
  final int duration;
  final String summaryId;
  final String doctorId;

  ConsultationModel({
    required this.consultationId,
    required this.doctorName,
    required this.doctorBio,
    required this.doctorImage,
    required this.startTime,
    required this.duration,
    required this.summaryId,
    required this.doctorId,
  });

  factory ConsultationModel.fromJson(Map<String, dynamic> json) {
    return ConsultationModel(
      consultationId: json['consultationId'],
      doctorName: json['doctorName'] ?? 'no_name',
      doctorBio: json['doctorBio'] ?? 'no_bio',
      doctorImage: json['doctorImage'] ?? '',
      startTime: DateTime.parse(json['startTime']),
      duration: json['duration'],
      summaryId: json['summaryId'] ?? 'no_summary_yet',
      doctorId: json['doctorId'],
    );
  }

  ConsultationEntity toEntity() {
    return ConsultationEntity(
      consultationId: consultationId,
      doctorName: doctorName,
      doctorBio: doctorBio,
      doctorImage: doctorImage,
      startTime: startTime,
      duration: duration,
      summaryId: summaryId,
      doctorId: doctorId,
    );
  }
}
