extension NumberRange on int {
  bool isBetween(int start, int end) => this >= start && this <= end;
}
