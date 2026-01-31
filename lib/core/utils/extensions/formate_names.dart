extension FormatNames on String {
  String format() {
    return this[0].toUpperCase() + substring(1).toLowerCase();
  }
}
