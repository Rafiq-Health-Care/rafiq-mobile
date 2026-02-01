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
            border: appTheme.textFieldBorder,
            enabledBorder: appTheme.textFieldBorder,
            focusedBorder: appTheme.textFieldBorder.copyWith(
              borderSide: BorderSide(
                color: appTheme.deepDarkBlueColor,
                width: 1.5,
              ),
            ),
            fillColor: Color(0x80F3F6FB),
            filled: true,
            suffixIcon: IconButton(
              icon: _obscure
                  ? const Icon(Icons.visibility_off, color: Colors.grey)
                  : Icon(Icons.visibility, color: appTheme.deepDarkBlueColor),
              onPressed: () => setState(() => _obscure = !_obscure),
            ),
          ),
          style: appTheme.textFieldTextStyle,
        ),
      ],
    );
  }
}
