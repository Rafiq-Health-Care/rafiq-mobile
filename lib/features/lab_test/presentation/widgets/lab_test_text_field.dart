import 'package:flutter/material.dart';
import 'package:rafiq/core/utils/extensions/get_app_theme.dart';

class LabTestTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final IconData icon;
  final TextInputType keyboardType;
  final double? iconSize;
  final String? Function(String?)? validator;

  const LabTestTextField({
    super.key,
    required this.controller,
    required this.label,
    required this.icon,
    this.keyboardType = TextInputType.text,
    this.iconSize,
    required this.validator,
  });

  @override
  Widget build(BuildContext context) {
    final appTheme = context.appTheme;
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, size: iconSize),
        border: appTheme.textFieldBorder,
        enabledBorder: appTheme.textFieldBorder,
        focusedBorder: appTheme.textFieldBorder.copyWith(
          borderSide: BorderSide(color: appTheme.deepDarkBlueColor, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
        filled: true,
        fillColor: Colors.grey[50],
      ),
      validator: validator,
    );
  }
}
