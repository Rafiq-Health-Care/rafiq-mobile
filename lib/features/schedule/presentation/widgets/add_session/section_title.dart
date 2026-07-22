import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq/core/utils/extensions/get_app_theme.dart';

class SectionTitle extends StatelessWidget {
  final String title;
  final IconData icon;

  const SectionTitle({super.key, required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    final appTheme = context.appTheme;
    return Row(
      children: [
        Container(
          width: 18.w,
          height: 20.h,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: appTheme.deepDarkBlueColor,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Icon(icon, size: 13.sp, color: Colors.white),
        ),
        SizedBox(width: 8.w),
        Text(
          title,
          style: appTheme.headingTextStyle.copyWith(
            fontSize: 20.sp,
            height: 28 / 20,
          ),
        ),
      ],
    );
  }
}
