import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:rafiq/core/theme/app_theme.dart';
import 'package:rafiq/features/auth/presentation/widgets/text_with_action_link.dart';
import 'package:rafiq/features/landing/presentation/widgets/custom_elevated_button.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

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
                  // call resend OTP endpoint
                },
              ),
              const SizedBox(height: 30),
              CustomElevatedButton(
                onPressed: () {
                  final code = _pinController.text;
                  if (code.length == 6) {
                    // call send OTP endpoint
                    // check response
                    // if it ok -> next
                    // else show message by snackBar or tost or any other way
                  }
                },
                backgroundColor: appTheme.deepDarkBlueColor,
                foregroundColor: appTheme.surfaceColor,
                child: Text('Submit', style: appTheme.buttonLabelTextStyle),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
