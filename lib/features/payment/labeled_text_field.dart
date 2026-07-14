import 'package:flutter/material.dart';
import 'package:rafiq/core/widgets/custom_labeled_text_field.dart';

class LabeledTextField2 extends StatelessWidget {
  final String label;
  final String hint;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final ValueChanged<String>? onChanged;

  const LabeledTextField2({
    super.key,
    required this.label,
    required this.hint,
    required this.controller,
    this.keyboardType = TextInputType.text,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return CustomLabeledTextField(
      hint: hint,
      controller: controller,
      label: label,
      keyboardType: keyboardType,
      onChanged: onChanged,
    );
  }
}
