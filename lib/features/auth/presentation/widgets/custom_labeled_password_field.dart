import 'package:flutter/material.dart';
import 'package:rafiq/core/utils/extensions/get_app_theme.dart';
import 'package:rafiq/features/auth/data/models/password_rule.dart';
import 'package:rafiq/features/auth/data/models/password_validator.dart';
import 'package:rafiq/features/auth/presentation/widgets/password_rules_card.dart';

class CustomLabeledPasswordField extends StatefulWidget {
  final String label;
  final String hint;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final void Function(String)? onFieldSubmitted;
  final TextInputAction? textInputAction;
  final bool showValidationRules;

  const CustomLabeledPasswordField({
    super.key,
    required this.label,
    required this.hint,
    required this.controller,
    this.validator,
    this.onFieldSubmitted,
    this.textInputAction,
    this.showValidationRules = false,
  });

  @override
  State<CustomLabeledPasswordField> createState() =>
      _CustomLabeledPasswordFieldState();
}

class _CustomLabeledPasswordFieldState
    extends State<CustomLabeledPasswordField> {
  bool _obscure = true;
  final FocusNode _focusNode = FocusNode();
  late PasswordValidator validator;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() => setState(() {}));
    validator = PasswordValidator(
      rules: [
        PasswordRule(
          text: 'At least 8 characters',
          validator: (value) => value.length >= 8,
        ),
        PasswordRule(
          text: 'Contains capital letter',
          validator: (value) => RegExp(r'[A-Z]').hasMatch(value),
        ),
        PasswordRule(
          text: 'Contains small letter',
          validator: (value) => RegExp(r'[a-z]').hasMatch(value),
        ),
        PasswordRule(
          text: 'Contains number',
          validator: (value) => RegExp(r'[0-9]').hasMatch(value),
        ),
        PasswordRule(
          text: 'Contains special character',
          validator: (value) =>
              RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  void validate(String value) => setState(() => validator.validate(value));

  bool get shouldShowRules {
    return widget.showValidationRules &&
        widget.controller.text.isNotEmpty &&
        (!validator.isValid || _focusNode.hasFocus);
  }

  @override
  Widget build(BuildContext context) {
    final appTheme = context.appTheme;
    return Column(
      spacing: 10,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.label, style: appTheme.textFieldLabelTextStyle),
        TextFormField(
          controller: widget.controller,
          obscureText: _obscure,
          focusNode: _focusNode,
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
            fillColor: appTheme.fieldFillColor,
            filled: true,
            suffixIcon: IconButton(
              icon: _obscure
                  ? const Icon(Icons.visibility_off, color: Colors.grey)
                  : Icon(Icons.visibility, color: appTheme.deepDarkBlueColor),
              onPressed: () => setState(() => _obscure = !_obscure),
            ),
          ),
          style: appTheme.textFieldTextStyle,
          onTapOutside: (_) => FocusScope.of(context).unfocus(),
          onFieldSubmitted: widget.onFieldSubmitted,
          textInputAction: widget.textInputAction,
          onChanged: validate,
        ),

        if (shouldShowRules) ...[
          const SizedBox(height: 8),
          PasswordRulesCard(validator: validator),
        ],
      ],
    );
  }
}
