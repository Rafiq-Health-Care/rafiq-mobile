import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq/core/functions/snack_bar_message.dart';
import 'package:rafiq/core/utils/extensions/get_app_theme.dart';
import 'package:rafiq/core/widgets/custom_app_bar.dart';
import 'package:rafiq/core/widgets/custom_elevated_button.dart';
import 'package:rafiq/features/auth/controllers/password_management_cubit/password_management_cubit.dart';
import 'package:rafiq/core/services/validation.dart';
import 'package:rafiq/features/auth/data/models/reset_password_request.dart';
import 'package:rafiq/features/auth/presentation/widgets/custom_labeled_password_field.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _oldPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmNewPasswordController = TextEditingController();

  @override
  void dispose() {
    _newPasswordController.dispose();
    _oldPasswordController.dispose();
    _confirmNewPasswordController.dispose();
    super.dispose();
  }

  void onSubmit() {
    if (_formKey.currentState!.validate()) {
      PasswordManagementCubit.get(context).resetPassword(
        ResetPasswordRequest(
          oldPassword: _oldPasswordController.text.trim(),
          newPassword: _newPasswordController.text.trim(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final appTheme = context.appTheme;
    return Scaffold(
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.lock_reset_rounded,
                size: 190.r,
                color: appTheme.deepDarkBlueColor,
              ),
              const SizedBox(height: 12),
              Text(
                'Reset Password',
                style: appTheme.headingTextStyle.copyWith(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                'Please  enter a new password for your account. Make sure it’s something secure.',
                style: appTheme.bodyTextStyle.copyWith(
                  color: appTheme.greyColor7,
                  fontSize: 14.sp,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              CustomLabeledPasswordField(
                label: 'Old Password',
                hint: 'Enter your old password',
                controller: _oldPasswordController,
                validator: Validation.validatePassword,
              ),
              const SizedBox(height: 16),
              CustomLabeledPasswordField(
                label: 'New Password',
                hint: 'Enter your new password',
                controller: _newPasswordController,
                validator: Validation.validatePassword,
              ),
              const SizedBox(height: 16),
              CustomLabeledPasswordField(
                label: 'Confirm New Password',
                hint: 'Confirm your new password',
                controller: _confirmNewPasswordController,
                validator: (value) {
                  return Validation.confirmPassword(
                    value,
                    _newPasswordController.text,
                  );
                },
              ),
              const SizedBox(height: 32),
              BlocConsumer<PasswordManagementCubit, PasswordManagementState>(
                listener: (context, state) {
                  if (state is PasswordChanged) {
                    Navigator.of(context).pop();
                  } else if (state is PasswordManagementError) {
                    snackBarMessage(context, state.message);
                  }
                },
                builder: (context, state) {
                  bool isLoading = state is PasswordManagementLoading;
                  return SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: CustomElevatedButton(
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
                              'Reset Password',
                              style: appTheme.buttonLabelTextStyle,
                            ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
