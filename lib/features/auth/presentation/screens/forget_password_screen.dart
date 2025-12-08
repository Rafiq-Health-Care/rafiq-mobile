import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rafiq/core/functions/snack_bar_message.dart';
import 'package:rafiq/core/router/router_strings.dart';
import 'package:rafiq/core/theme/app_theme.dart';
import 'package:rafiq/core/widgets/custom_elevated_button.dart';
import 'package:rafiq/core/widgets/custom_labeled_text_field.dart';
import 'package:rafiq/features/auth/controllers/forget_password_cubit/forget_password_cubit.dart';
import 'package:rafiq/core/services/validation.dart';
import 'package:rafiq/features/auth/presentation/widgets/text_with_action_link.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void onSubmit() {
    if (_formKey.currentState!.validate()) {
      ForgetPasswordCubit.get(
        context,
      ).forgetPassword(_emailController.text.trim());
    }
  }

  @override
  Widget build(BuildContext context) {
    final appTheme = Theme.of(context).extension<AppTheme>()!;

    return Scaffold(
      appBar: AppBar(title: const Text('Forgot Password'), centerTitle: true),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 20),

                // Icon
                Icon(
                  Icons.lock_reset_rounded,
                  size: 80,
                  color: appTheme.deepDarkBlueColor,
                ),

                const SizedBox(height: 24),

                // Title
                Text(
                  'Reset Password',
                  style: appTheme.bodyLargeTextStyle,
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 12),

                // Description
                Text(
                  'Enter your email address and we\'ll send you a link to reset your password.',
                  style: appTheme.bodyTextStyle.copyWith(
                    color: Colors.grey[600],
                  ),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 40),

                // Email Field
                CustomLabeledTextField(
                  label: 'Email Address',
                  hint: 'Enter your email',
                  controller: _emailController,
                  validator: Validation.validateEmail,
                  keyboardType: TextInputType.emailAddress,
                ),

                const SizedBox(height: 32),

                // Submit Button
                BlocConsumer<ForgetPasswordCubit, ForgetPasswordState>(
                  listener: (context, state) {
                    if (state is ForgetPasswordEmailSent) {
                      Navigator.of(
                        context,
                      ).pushNamed(RouterStrings.otp, arguments: true);
                    } else if (state is ForgetPasswordError) {
                      snackBarMessage(context, state.message);
                    }
                  },
                  builder: (context, state) {
                    bool isLoading = state is ForgetPasswordLoading;
                    return CustomElevatedButton(
                      onPressed: () {
                        if (!isLoading) {
                          onSubmit();
                        }
                      },
                      backgroundColor: appTheme.deepDarkBlueColor,
                      foregroundColor: appTheme.surfaceColor,
                      child: isLoading
                          ? const CircularProgressIndicator()
                          : Text(
                              'Submit',
                              style: appTheme.buttonLabelTextStyle,
                            ),
                    );
                  },
                ),

                const SizedBox(height: 24),

                // Back to Login
                TextWithActionLink(
                  staticText: 'Remember your password? ',
                  linkText: 'Login',
                  onTap: () => Navigator.pop(context),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
