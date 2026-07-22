class FeedbackEntity {
  final int rating;
  final String comment;
  final String patientName;
  final DateTime createdAt;

  FeedbackEntity({
    required this.rating,
    required this.comment,
    required this.patientName,
    required this.createdAt,
  });
}
