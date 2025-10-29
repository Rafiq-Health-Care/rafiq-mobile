import 'package:flutter/material.dart';
import 'package:rafiq/core/router/router_strings.dart';
import 'package:rafiq/core/theme/app_theme.dart';
import 'package:rafiq/features/auth/data/service/validation.dart';
import 'package:rafiq/features/auth/presentation/widgets/custom_labeled_password_field.dart';
import 'package:rafiq/core/widgets/custom_labeled_text_field.dart';

class LoginFormSection extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomLabeledTextField(
          label: 'Email',
          hint: 'example@example.com',
          controller: emailController,
          validator: Validation.validateEmail,
        ),
        SizedBox(height: 24),
        CustomLabeledPasswordField(
          label: 'Password',
          hint: '1234...',
          controller: passwordController,
          validator: Validation.validatePassword,
        ),
        SizedBox(height: 8),
        Align(
          alignment: Alignment.centerRight,
          child: TextButton(
            onPressed: () {
              Navigator.of(context).pushNamed(RouterStrings.forgetPassword);
            },
            child: Text("Forget Password", style: appTheme.bodyTextStyle),
          ),
        ),
      ],
    );
  }
}
