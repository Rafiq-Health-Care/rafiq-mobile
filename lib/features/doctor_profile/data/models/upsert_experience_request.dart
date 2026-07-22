/// Body shared by `POST /api/v1/doctor/experience` (add) and
/// `PUT /api/v1/doctor/experience/{expId}` (edit) — same shape either way.
class UpsertExperienceRequest {
  final String position;
  final String hospitalName;
  final DateTime startDate;
  final DateTime? endDate;
  final String description;
  final bool currentJob;

  const UpsertExperienceRequest({
    required this.position,
    required this.hospitalName,
    required this.startDate,
    this.endDate,
    required this.description,
    required this.currentJob,
  });

  Map<String, dynamic> toJson() {
    return {
      'position': position,
      'hospitalName': hospitalName,
      'startDate': _formatDate(startDate),
      // The API always expects an endDate; while the job is still current
      // we just echo the start date back rather than sending null.
      'endDate': _formatDate(currentJob ? startDate : (endDate ?? startDate)),
      'description': description,
      'currentJob': currentJob,
    };
  }

  static String _formatDate(DateTime date) {
    final y = date.year.toString().padLeft(4, '0');
    final m = date.month.toString().padLeft(2, '0');
    final d = date.day.toString().padLeft(2, '0');
    return '$y-$m-$d';
  }
}
