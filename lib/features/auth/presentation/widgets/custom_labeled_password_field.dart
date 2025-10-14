import 'package:flutter/material.dart';
import 'package:rafiq/core/theme/app_theme.dart';

class CustomLabeledPasswordField extends StatefulWidget {
  final String label;
  final String hint;
  final TextEditingController controller;
  final String? Function(String?)? validator;

  const CustomLabeledPasswordField({
    super.key,
    required this.label,
    required this.hint,
    required this.controller,
    required this.validator,
  });

  @override
  State<CustomLabeledPasswordField> createState() =>
      _CustomLabeledPasswordFieldState();
}

class _CustomLabeledPasswordFieldState
    extends State<CustomLabeledPasswordField> {
  bool _obscure = true;

  @override
  Widget build(BuildContext context) {
    final AppTheme appTheme = Theme.of(context).extension<AppTheme>()!;
    return Column(
      spacing: 10,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.label, style: appTheme.textFieldLabelTextStyle),
        TextFormField(
          controller: widget.controller,
          obscureText: _obscure,
          validator: widget.validator,
          decoration: InputDecoration(
            hintText: widget.hint,
            hintStyle: appTheme.textFieldHintTextStyle,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.grey),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: appTheme.accentBlueColor, width: 2),
            ),
            suffixIcon: IconButton(
              icon: _obscure
                  ? const Icon(Icons.visibility_off, color: Colors.grey)
                  : Icon(Icons.visibility, color: appTheme.accentBlueColor),
              onPressed: () => setState(() => _obscure = !_obscure),
            ),
          ),
          style: appTheme.textFieldTextStyle,
        ),
      ],
    );
  }
}
