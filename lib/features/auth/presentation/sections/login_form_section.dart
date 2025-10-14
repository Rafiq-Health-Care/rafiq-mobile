import 'package:flutter/material.dart';
import 'package:rafiq/core/theme/app_theme.dart';
import 'package:rafiq/features/auth/presentation/widgets/custom_labeled_password_field.dart';
import 'package:rafiq/features/auth/presentation/widgets/custom_labeled_text_field.dart';

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
          validator: null,
        ),
        SizedBox(height: 24),
        CustomLabeledPasswordField(
          label: 'Password',
          hint: '1234...',
          controller: passwordController,
          validator: null,
        ),
        SizedBox(height: 8),
        Align(
          alignment: Alignment.centerRight,
          child: TextButton(
            onPressed: () {},
            child: Text("Forget Password", style: appTheme.bodyTextStyle),
          ),
        ),
      ],
    );
  }
}
