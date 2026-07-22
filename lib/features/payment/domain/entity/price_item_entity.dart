/// A single label/value row in the payment info breakdown,
/// e.g. "Total price" -> "$75.00".
class PriceItem {
  final String label;
  final String value;

  const PriceItem({required this.label, required this.value});
}

/// Holds the full pricing breakdown shown on the Consultation Summary /
/// payment screen.
class ConsultationSummary {
  final double totalPrice;
  final double tax;
  final double insurance;
  final double finalTotal;

  const ConsultationSummary({
    required this.totalPrice,
    required this.tax,
    required this.insurance,
    required this.finalTotal,
  });

  String get totalPriceLabel => '\$${totalPrice.toStringAsFixed(2)}';
  String get taxLabel => tax == tax.roundToDouble()
      ? '\$${tax.toStringAsFixed(0)}'
      : '\$${tax.toStringAsFixed(2)}';
  String get insuranceLabel => insurance == insurance.roundToDouble()
      ? '\$${insurance.toStringAsFixed(0)}'
      : '\$${insurance.toStringAsFixed(2)}';
  String get finalTotalLabel => '\$${finalTotal.toStringAsFixed(2)}';

  List<PriceItem> get breakdown => [
        PriceItem(label: 'Total price', value: totalPriceLabel),
        PriceItem(label: 'Tax', value: taxLabel),
        PriceItem(label: 'Insurances', value: insuranceLabel),
      ];
}
