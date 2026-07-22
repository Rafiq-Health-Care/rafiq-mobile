class AddSlotParams {
  final DateTime startTime;
  final int durationInMinutes;

  const AddSlotParams({
    required this.startTime,
    this.durationInMinutes = fixedDurationMinutes,
  });

  static const int fixedDurationMinutes = 30;
}
