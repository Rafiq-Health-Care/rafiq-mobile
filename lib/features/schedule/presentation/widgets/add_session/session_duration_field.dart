import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq/core/utils/extensions/get_app_theme.dart';
import 'package:rafiq/features/schedule/domain/params/add_slot_params.dart';

/// Duration is fixed on the backend for now — `POST /slot` doesn't accept a
/// custom duration, so this is a read-only info badge, not an input.
class SessionDurationField extends StatelessWidget {
  const SessionDurationField({super.key});

  @override
  Widget build(BuildContext context) {
    final appTheme = context.appTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Duration',
          style: appTheme.textFieldLabelTextStyle.copyWith(
            fontFamily: 'Inter',
            fontWeight: FontWeight.w600,
            fontSize: 13.sp,
            height: 20 / 13,
            color: appTheme.labelColor,
          ),
        ),
        SizedBox(height: 8.h),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
          decoration: BoxDecoration(
            color: appTheme.infoBackgroundColor,
            border: Border.all(color: appTheme.infoBorderColor),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            children: [
              Icon(Icons.schedule, size: 18.sp, color: appTheme.tealAccentColor),
              SizedBox(width: 8.w),
              Text(
                '${AddSlotParams.fixedDurationMinutes} Minutes (Fixed)',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w600,
                  fontSize: 14.sp,
                  height: 24 / 14,
                  color: appTheme.tealAccentColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
