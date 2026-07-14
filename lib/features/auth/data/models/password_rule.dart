class PasswordRule {
  final String text;
  final bool Function(String) validator;
  bool isValid;

  PasswordRule({
    required this.text,
    required this.validator,
    this.isValid = false,
  });

  void validate(String value) {
    isValid = validator(value);
  }
}
