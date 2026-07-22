import 'package:rafiq/features/feedback/domain/entities/feedback_entity.dart';

class FeedbackModel {
  final int rating;
  final String comment;
  final String patientName;
  final DateTime createdAt;

  FeedbackModel({
    required this.rating,
    required this.comment,
    required this.patientName,
    required this.createdAt,
  });

  factory FeedbackModel.fromJson(Map<String, dynamic> json) {
    return FeedbackModel(
      rating: (json['rating'] as num?)?.toInt() ?? 0,
      comment: json['comment'] ?? '',
      patientName: json['patientName'] ?? '',
      createdAt:
          DateTime.tryParse(json['createdAt']?.toString() ?? '') ??
          DateTime.now(),
    );
  }

  FeedbackEntity toEntity() {
    return FeedbackEntity(
      rating: rating,
      comment: comment,
      patientName: patientName,
      createdAt: createdAt,
    );
  }
}
