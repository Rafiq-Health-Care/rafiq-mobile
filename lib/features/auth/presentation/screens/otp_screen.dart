import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinput/pinput.dart';
import 'package:rafiq/core/functions/snack_bar_message.dart';
import 'package:rafiq/core/router/router_strings.dart';
import 'package:rafiq/core/services/validation.dart';
import 'package:rafiq/core/theme/app_theme.dart';
import 'package:rafiq/core/utils/image_url.dart';
import 'package:rafiq/core/widgets/custom_app_bar.dart';
import 'package:rafiq/features/auth/controllers/auth_cubit/auth_cubit.dart';
import 'package:rafiq/features/auth/presentation/widgets/text_with_action_link.dart';
import 'package:rafiq/core/widgets/custom_elevated_button.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _pinController = TextEditingController();
  bool canResend = false;
  Timer? _timer;

  void resetTimer() {
    canResend = false;
    _timer?.cancel();
    _timer = Timer(const Duration(minutes: 5), () {
      canResend = true;
    });
  }

  @override
  void initState() {
    super.initState();
    resetTimer();
  }

  @override
  void dispose() {
    super.dispose();
    _pinController.dispose();
    _timer?.cancel();
  }

  void onSubmit() {
    if (_formKey.currentState!.validate()) {
      AuthCubit.get(context).userVerification(_pinController.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    final appTheme = Theme.of(context).extension<AppTheme>()!;
    final AuthCubit authCubit = AuthCubit.get(context);
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(ImageUrl().otpLogo, height: size.height * 0.25),
                const SizedBox(height: 16),
                Text(
                  'OTP Verification Code',
                  style: appTheme.headingTextStyle.copyWith(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Enter the OTP code sent to your email',
                  style: appTheme.bodyTextStyle.copyWith(
                    color: appTheme.greyColor7,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 30),
                Pinput(
                  length: 6,
                  controller: _pinController,
                  validator: Validation.validateOtp,
                  focusedPinTheme: PinTheme(
                    width: 40,
                    height: 54,
                    textStyle: appTheme.headingTextStyle.copyWith(fontSize: 24),
                    decoration: BoxDecoration(
                      color: appTheme.fieldFillColor,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Color(0x268AA9D2)),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                TextWithActionLink(
                  staticText: "Didn't receive a code? ",
                  linkText: 'Click here to resend.',
                  staticTextStyle: appTheme.bodyTextStyle.copyWith(
                    color: appTheme.greyColor7,
                    fontSize: 15,
                  ),
                  linkTextStyle: appTheme.bodyTextStyle.copyWith(
                    color: appTheme.accentRedColor,
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
                  ),
                  onTap: () {
                    if (canResend) {
                      authCubit.sendNewOtp();
                    }
                  },
                ),
                SizedBox(height: size.height * 0.25),
                SizedBox(
                  width: size.width * 0.8,
                  child: customButton(appTheme, context),
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget customButton(final AppTheme appTheme, final BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is UserVerificationSuccess) {
          Navigator.of(
            context,
          ).pushNamedAndRemoveUntil(RouterStrings.home, (route) => false);
        } else if (state is AuthFailure) {
          snackBarMessage(context, state.message);
        } else if (state is UserVerificationResendSuccess) {
          resetTimer();
        }
      },
      
      child: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, authState) {
          bool isLoading = authState is AuthLoading;
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
                : Text('Verify Account', style: appTheme.buttonLabelTextStyle),
          );
        },
      ),
    );
  }
}
