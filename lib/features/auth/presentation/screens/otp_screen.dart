import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinput/pinput.dart';
import 'package:rafiq/core/functions/snack_bar_message.dart';
import 'package:rafiq/core/router/router_strings.dart';
import 'package:rafiq/core/theme/app_theme.dart';
import 'package:rafiq/features/auth/controllers/otp_cubit/otp_cubit.dart';
import 'package:rafiq/features/auth/data/models/user_verification_request.dart';
import 'package:rafiq/features/auth/presentation/widgets/text_with_action_link.dart';
import 'package:rafiq/core/widgets/custom_elevated_button.dart';

class OtpScreen extends StatefulWidget {
  final String email;
  const OtpScreen({super.key, required this.email});

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

  @override
  Widget build(BuildContext context) {
    final appTheme = Theme.of(context).extension<AppTheme>()!;
    final OtpCubit authCubit = OtpCubit.get(context);
    final String email = widget.email;

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
                    color: Color(0xFFB8CBE8),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: appTheme.deepDarkBlueColor.withAlpha(235),
                    ),
                  ),
                ),
              ),
              const Spacer(),
              TextWithActionLink(
                staticText: "Didn't receive a code? ",
                linkText: 'Resend code',
                onTap: () {
                  authCubit.sendNewOtp(email);
                },
              ),
              const SizedBox(height: 30),
              BlocConsumer<OtpCubit, OtpState>(
                listener: (context, state) {
                  if (state is OtpSuccess) {
                    // Navigator.of(context).pushNamed(RouterStrings.otp);
                    if (kDebugMode) {
                      print('Success');
                    }
                  } else if (state is OtpFailure) {
                    snackBarMessage(context, state.message);
                  }
                },
                builder: (context, state) {
                  bool isLoading = state is OtpLoading;
                  return CustomElevatedButton(
                    onPressed: () {
                      final code = _pinController.text;
                      if (code.length == 6 && !isLoading) {
                        authCubit.userVerification(
                          UserVerificationRequest(email: email, otp: code),
                        );
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
            ],
          ),
        ),
      ),
    );
  }
}
