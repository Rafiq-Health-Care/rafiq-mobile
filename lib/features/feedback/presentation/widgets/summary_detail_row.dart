import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq/core/utils/extensions/get_app_theme.dart';

class SummaryDetailRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const SummaryDetailRow({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final appTheme = context.appTheme;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 48.w,
          height: 48.h,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: appTheme.lightIconContainerColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, size: 18.sp, color: appTheme.deepDarkBlueColor),
        ),
        SizedBox(width: 16.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label.toUpperCase(),
                style: appTheme.overlineTextStyle.copyWith(
                  fontFamily: 'Manrope',
                  fontSize: 12.sp,
                  letterSpacing: 0.6,
                  color: appTheme.bodyMutedColor,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                value,
                style: appTheme.valueTextStyle.copyWith(
                  fontFamily: 'Manrope',
                  fontWeight: FontWeight.w600,
                  fontSize: 16.sp,
                  color: appTheme.inputTextColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
