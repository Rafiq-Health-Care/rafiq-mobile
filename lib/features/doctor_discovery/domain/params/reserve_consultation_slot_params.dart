class ReserveConsultationSlotParams {
  final String slotId;
  final String notes;
  final String provider;

  ReserveConsultationSlotParams({
    required this.slotId,
    required this.notes,
    this.provider = "STRIPE",
  });

  Map<String, String> toBodyJson() {
    return {
      "slotId": slotId,
      "notes": notes,
      "provider": provider,
    };
  }
}
