extension FormatNames on String {
  String format() {
    return this[0].toUpperCase() + substring(1).toLowerCase();
  }
  
  String toReadableFormat() {
    if (isEmpty) return this;

    return split('_')
        .map((word) {
          if (word.isEmpty) return '';
          return word[0].toUpperCase() + word.substring(1).toLowerCase();
        })
        .join(' ');
  }
}
