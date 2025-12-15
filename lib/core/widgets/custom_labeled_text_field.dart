import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rafiq/core/theme/app_theme.dart';

class CustomLabeledTextField extends StatelessWidget {
  final String label;
  final String hint;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final String? prefixText;

  const CustomLabeledTextField({
    super.key,
    required this.hint,
    required this.controller,
    required this.validator,
    this.keyboardType = TextInputType.text,
    required this.label,
    this.inputFormatters,
    this.prefixText,
  });

  @override
  Widget build(BuildContext context) {
    final AppTheme appTheme = Theme.of(context).extension<AppTheme>()!;
    return Column(
      spacing: 10,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: appTheme.textFieldLabelTextStyle),
        TextFormField(
          controller: controller,
          validator: validator,
          decoration: InputDecoration(
            hintText: hint,
            prefixText: prefixText,
            prefixStyle: appTheme.textFieldTextStyle,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),

            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.grey),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: appTheme.accentBlueColor, width: 2),
            ),
            hintStyle: appTheme.textFieldHintTextStyle,
          ),
          style: appTheme.textFieldTextStyle,
          keyboardType: keyboardType,
          inputFormatters: inputFormatters,
        ),
      ],
    );
  }
}
