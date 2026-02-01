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
  final int numberOfLines;

  const CustomLabeledTextField({
    super.key,
    required this.hint,
    required this.controller,
    this.validator,
    this.keyboardType = TextInputType.text,
    required this.label,
    this.inputFormatters,
    this.prefixText,
    this.numberOfLines = 1,
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
            border: appTheme.textFieldBorder,
            enabledBorder: appTheme.textFieldBorder,
            focusedBorder: appTheme.textFieldBorder.copyWith(
              borderSide: BorderSide(
                color: appTheme.deepDarkBlueColor,
                width: 1.5,
              ),
            ),
            hintStyle: appTheme.textFieldHintTextStyle,
            fillColor: Color(0x80F3F6FB),
            filled: true,
          ),
          style: appTheme.textFieldTextStyle,
          keyboardType: keyboardType,
          inputFormatters: inputFormatters,
          maxLines: numberOfLines,
          minLines: numberOfLines,
        ),
      ],
    );
  }
}
