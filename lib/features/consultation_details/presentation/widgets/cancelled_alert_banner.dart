// cancelled_alert_banner.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq/core/utils/extensions/get_app_theme.dart';

class CancelledAlertBanner extends StatelessWidget {
  const CancelledAlertBanner({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: theme.accentRedColor.withOpacity(0.12),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Row(
        children: [
          Icon(Icons.error_outline, size: 16.sp, color: theme.accentRedColor),
          SizedBox(width: 8.w),
          Expanded(
            child: Text(
              'This appointment will not take place as scheduled.',
              style: theme.captionTextStyle.copyWith(color: theme.accentRedColor, height: 1.4),
            ),
          ),
        ],
      ),
    );
  }
}