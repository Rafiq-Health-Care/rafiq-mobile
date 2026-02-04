import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq/core/functions/snack_bar_message.dart';
import 'package:rafiq/core/router/router_strings.dart';
import 'package:rafiq/core/theme/app_theme.dart';
import 'package:rafiq/core/utils/image_url.dart';
import 'package:rafiq/core/widgets/custom_app_bar.dart';
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
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 20),
              Image.asset(
                ImageUrl().forgetPassword,
                width: 204.r,
                height: 204.r,
              ),
              const SizedBox(height: 24),
              Text(
                'Forget Your Password?',
                style: appTheme.headingTextStyle.copyWith(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              Text(
                'No worries! Enter your registered email\naddress below and we will send you a link to\nreset your password.',
                style: appTheme.bodyTextStyle.copyWith(
                  color: appTheme.greyColor7,
                  fontSize: 14.sp,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              CustomLabeledTextField(
                label: 'Email Address',
                hint: 'Enter your email',
                controller: _emailController,
                validator: Validation.validateEmail,
                keyboardType: TextInputType.emailAddress,
                prefixIcon: Icon(
                  Icons.email,
                  color: appTheme.deepDarkBlueColor,
                ),
              ),
              const SizedBox(height: 32),
              BlocConsumer<ForgetPasswordCubit, ForgetPasswordState>(
                listener: (context, state) {
                  if (state is ForgetPasswordEmailSent) {
                    Navigator.of(
                      context,
                    ).pushReplacementNamed(RouterStrings.checkEmail);
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
                            'Send Reset Link',
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
    );
  }
}
