import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinput/pinput.dart';
import 'package:rafiq/core/functions/snack_bar_message.dart';
import 'package:rafiq/core/router/router_strings.dart';
import 'package:rafiq/core/theme/app_theme.dart';
import 'package:rafiq/features/auth/controllers/auth_cubit/auth_cubit.dart';
import 'package:rafiq/features/auth/controllers/forget_password_cubit/forget_password_cubit.dart';
import 'package:rafiq/features/auth/presentation/widgets/text_with_action_link.dart';
import 'package:rafiq/core/widgets/custom_elevated_button.dart';

class OtpScreen extends StatefulWidget {
  final bool isForgetPassword;
  const OtpScreen({super.key, required this.isForgetPassword});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final _pinController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _pinController.dispose();
  }

  void onSubmit() {
    final code = _pinController.text;

    if (code.length == 6) {
      widget.isForgetPassword
          ? ForgetPasswordCubit.get(context).userVerify(code)
          : AuthCubit.get(context).userVerification(code);
    }
  }

  @override
  Widget build(BuildContext context) {
    final appTheme = Theme.of(context).extension<AppTheme>()!;
    final AuthCubit authCubit = AuthCubit.get(context);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text('OTP Verification Code', style: appTheme.headingTextStyle),
              const Spacer(),
              const Text(
                'Enter the OTP code sent to your email',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              Pinput(
                length: 6,
                controller: _pinController,
                focusedPinTheme: PinTheme(
                  width: 50,
                  height: 50,
                  textStyle: appTheme.headingTextStyle.copyWith(fontSize: 20),
                  decoration: BoxDecoration(
                    color: appTheme.softBlueColor,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: appTheme.deepDarkBlueColor.withAlpha(235),
                    ),
                  ),
                ),
              ),
              const Spacer(),
              if (!widget.isForgetPassword)
                TextWithActionLink(
                  staticText: "Didn't receive a code? ",
                  linkText: 'Resend code',
                  onTap: () {
                    authCubit.sendNewOtp();
                  },
                ),
              const SizedBox(height: 30),
              customButton(appTheme, context),
            ],
          ),
        ),
      ),
    );
  }

  Widget customButton(final AppTheme appTheme, final BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is UserVerificationSuccess) {
              Navigator.of(
                context,
              ).pushNamedAndRemoveUntil(RouterStrings.home, (route) => false);
            } else if (state is AuthFailure) {
              snackBarMessage(context, state.message);
            }
          },
        ),
        BlocListener<ForgetPasswordCubit, ForgetPasswordState>(
          listener: (context, state) {
            if (state is ForgetPasswordOtpVerified) {
              Navigator.of(context).pushNamed(RouterStrings.changePassword);
            } else if (state is ForgetPasswordError) {
              snackBarMessage(context, state.message);
            }
          },
        ),
      ],
      child: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, authState) =>
            BlocBuilder<ForgetPasswordCubit, ForgetPasswordState>(
              builder: (context, forgetPasswordState) {
                bool isLoading =
                    authState is AuthLoading ||
                    forgetPasswordState is ForgetPasswordLoading;
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
                      : Text('Submit', style: appTheme.buttonLabelTextStyle),
                );
              },
            ),
      ),
    );
  }
}
