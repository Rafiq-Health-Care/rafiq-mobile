import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq/core/utils/extensions/get_app_theme.dart';

class SessionCompleteHeader extends StatelessWidget {
  const SessionCompleteHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final appTheme = context.appTheme;
    return Column(
      children: [
        Text(
          'Session Complete',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'Manrope',
            fontWeight: FontWeight.w700,
            fontSize: 24.sp,
            height: 40 / 24,
            letterSpacing: -0.64,
            color: appTheme.inputTextColor,
          ),
        ),
        SizedBox(height: 20.h),
        Text(
          'Your consultation has been successfully '
          'finalized. You can now access your medical summary and next '
          'steps.',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'Manrope',
            fontWeight: FontWeight.w400,
            fontSize: 14.sp,
            height: 24 / 14,
            color: appTheme.bodyMutedColor,
          ),
        ),
      ],
    );
  }
}
