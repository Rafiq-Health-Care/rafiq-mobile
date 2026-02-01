import 'package:flutter/material.dart';
import 'package:rafiq/core/router/router_strings.dart';
import 'package:rafiq/core/theme/app_theme.dart';
import 'package:rafiq/core/services/validation.dart';
import 'package:rafiq/features/auth/presentation/widgets/custom_labeled_password_field.dart';
import 'package:rafiq/core/widgets/custom_labeled_text_field.dart';

class LoginFormSection extends StatefulWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final AppTheme appTheme;

  const LoginFormSection({
    super.key,
    required this.emailController,
    required this.passwordController,
    required this.appTheme,
  });

  @override
  State<LoginFormSection> createState() => _LoginFormSectionState();
}

class _LoginFormSectionState extends State<LoginFormSection> {
  final ValueNotifier<bool> _rememberMeNotifier = ValueNotifier(false);

  @override
  void dispose() {
    _rememberMeNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomLabeledTextField(
          label: 'Email Address',
          hint: 'Enter your email address',
          controller: widget.emailController,
          validator: Validation.validateEmail,
        ),
        SizedBox(height: 24),
        CustomLabeledPasswordField(
          label: 'Password',
          hint: 'Enter your password',
          controller: widget.passwordController,
          validator: Validation.validatePassword,
        ),
        SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: ValueListenableBuilder(
                valueListenable: _rememberMeNotifier,
                builder: (context, value, child) {
                  return Row(
                    children: [
                      Checkbox(
                        value: _rememberMeNotifier.value,
                        onChanged: (value) =>
                            _rememberMeNotifier.value = value!,
                        activeColor: widget.appTheme.deepDarkBlueColor,
                        checkColor: widget.appTheme.surfaceColor,
                        side: BorderSide(color: Color(0XFF718094), width: 1.5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      // const SizedBox(width: 4),
                      const Text(
                        'Remember me',
                        style: TextStyle(
                          color: Color(0XFF718094),
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pushNamed(RouterStrings.forgetPassword);
              },
              child: Text(
                "Forget Password?",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: widget.appTheme.deepDarkBlueColor,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
