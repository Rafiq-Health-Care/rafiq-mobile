import 'package:flutter/material.dart';
import 'package:rafiq/core/theme/app_theme.dart';
import 'package:rafiq/features/auth/presentation/sections/login_form_section.dart';
import 'package:rafiq/features/auth/presentation/sections/media_auth_section.dart';
import 'package:rafiq/features/auth/presentation/widgets/horizontal_text_divider.dart';
import 'package:rafiq/features/auth/presentation/widgets/text_with_action_link.dart';
import 'package:rafiq/features/landing/presentation/widgets/custom_elevated_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final AppTheme appTheme = Theme.of(context).extension<AppTheme>()!;
    return Scaffold(
      appBar: AppBar(
        title: Text('Log In', style: appTheme.headingTextStyle),
        elevation: 0,
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 32),
                Text("Welcome", style: appTheme.headingTextStyle),
                SizedBox(height: 32),
                LoginFormSection(
                  emailController: _emailController,
                  passwordController: _passwordController,
                  appTheme: appTheme,
                ),
                SizedBox(height: 32),
                CustomElevatedButton(
                  onPressed: () {},
                  backgroundColor: appTheme.deepDarkBlueColor,
                  foregroundColor: appTheme.surfaceColor,
                  child: Text('Log In', style: appTheme.buttonLabelTextStyle),
                ),
                SizedBox(height: 16),
                HorizontalTextDivider(),
                MediaAuthSection(),
                SizedBox(height: 32),
                TextWithActionLink(
                  staticText: "Don't have an account? ",
                  linkText: 'Sign up',
                  onTap: () {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
