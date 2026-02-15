import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq/core/utils/extensions/get_app_theme.dart';
import 'package:rafiq/core/utils/image_url.dart';
import 'package:rafiq/core/widgets/custom_app_bar.dart';
import 'package:rafiq/core/widgets/custom_elevated_button.dart';

class CheckEmailScreen extends StatelessWidget {
  const CheckEmailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appTheme = context.appTheme;
    return Scaffold(
      appBar: CustomAppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 20),
          Image.asset(ImageUrl().checkMail, width: 204.r, height: 204.r),
          const SizedBox(height: 24),
          Text(
            'Check Your Email',
            style: appTheme.headingTextStyle.copyWith(
              fontSize: 24.sp,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          Text(
            'We’ve sent a password recovery link to Your Email. Please click the link in the email to reset your password.',
            style: appTheme.bodyTextStyle.copyWith(
              color: appTheme.greyColor7,
              fontSize: 14.sp,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
          SizedBox(
            height: 63.h,
            width: MediaQuery.of(context).size.width * 0.8,
            child: CustomElevatedButton(
              onPressed: () => Navigator.pop(context),
              backgroundColor: appTheme.deepDarkBlueColor,
              foregroundColor: appTheme.surfaceColor,
              child: Text(
                'Back to Login',
                style: appTheme.buttonLabelTextStyle,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
