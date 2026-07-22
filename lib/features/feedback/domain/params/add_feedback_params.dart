class AddFeedbackParams {
  final double rating;
  final String comment;
  final String consultationId;

  const AddFeedbackParams({
    required this.rating,
    required this.comment,
    required this.consultationId,
  });
}
