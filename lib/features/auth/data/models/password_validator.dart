import 'package:rafiq/features/auth/data/models/password_rule.dart';

class PasswordValidator {
  final List<PasswordRule> rules;
  PasswordValidator({required this.rules});

  void validate(String value) {
    for (final rule in rules) {
      rule.validate(value);
    }
  }

  bool get isValid => rules.every((rule) => rule.isValid);
  double get strength =>
      rules.where((rule) => rule.isValid).length / rules.length;
}
