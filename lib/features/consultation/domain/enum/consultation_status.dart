enum ConsultationStatus { pending, completed, cancelled, upcoming, live }

extension ConsultationStatusX on ConsultationStatus {
  static ConsultationStatus fromApi(String raw) {
    return ConsultationStatus.values.firstWhere(
      (e) => e.name.toUpperCase() == raw.toUpperCase(),
      orElse: () => ConsultationStatus.pending,
    );
  }
}
