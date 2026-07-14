import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq/core/utils/extensions/get_app_theme.dart';

class SchedulingSectionHeader extends StatelessWidget {
  final String title;
  final String subtitle;
  const SchedulingSectionHeader({
    super.key,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    final appTheme = context.appTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: appTheme.textFieldLabelTextStyle.copyWith(
            letterSpacing: 1.5,
            fontSize: 13.sp,
            fontWeight: FontWeight.w800,
            color: appTheme.deepDarkBlueColor.withValues(alpha:0.4),
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          subtitle,
          style: appTheme.descriptionSmallTextStyle.copyWith(
            color: appTheme.deepDarkBlueColor.withValues(alpha:0.7),
          ),
        ),
      ],
    );
  }
}
