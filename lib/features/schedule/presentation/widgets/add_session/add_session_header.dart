import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq/core/utils/extensions/get_app_theme.dart';

class AddSessionHeader extends StatelessWidget {
  final VoidCallback onBack;

  const AddSessionHeader({super.key, required this.onBack});

  @override
  Widget build(BuildContext context) {
    final appTheme = context.appTheme;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        IconButton(
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
          onPressed: onBack,
          icon: Icon(
            Icons.arrow_back,
            color: appTheme.deepDarkBlueColor,
            size: 22.sp,
          ),
        ),
        SizedBox(width: 8.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Add Session',
                style: appTheme.headingTextStyle.copyWith(
                  fontSize: 20.sp,
                  height: 32 / 20,
                ),
              ),
              SizedBox(height: 2.h),
              Text(
                'Open up a new time slot for patients to book with you.',
                style: appTheme.textFieldHintTextStyle.copyWith(
                  fontFamily: 'Inter',
                  fontSize: 14.sp,
                  height: 24 / 14,
                  color: appTheme.mutedTextColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
