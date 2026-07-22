import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq/core/utils/extensions/get_app_theme.dart';

class WelcomeCard extends StatelessWidget {
  final String heading;
  final String message;
  final String disclaimer;

  const WelcomeCard({
    super.key,
    required this.heading,
    required this.message,
    required this.disclaimer,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          heading,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: context.appTheme.deepDarkBlueColor,
            fontSize: 26.sp,
            fontWeight: FontWeight.w800,
          ),
        ),
        SizedBox(height: 16.h),
        Text(
          message,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: context.appTheme.deepDarkBlueColor,
            fontSize: 18.sp,
            fontWeight: FontWeight.w500,
            height: 1.4,
          ),
        ),
        SizedBox(height: 14.h),
        Text(
          disclaimer,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Color(0xFF6B7A94),
            fontSize: 14.sp,
            fontStyle: FontStyle.italic,
            height: 1.4,
          ),
        ),
      ],
    );
  }
}
