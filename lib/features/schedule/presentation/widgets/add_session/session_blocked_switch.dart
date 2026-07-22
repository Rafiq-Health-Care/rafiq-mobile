import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq/core/utils/extensions/get_app_theme.dart';

class SessionBlockedSwitch extends StatelessWidget {
  final ValueNotifier<bool> isBlockedNotifier;

  const SessionBlockedSwitch({super.key, required this.isBlockedNotifier});

  @override
  Widget build(BuildContext context) {
    final appTheme = context.appTheme;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40.w,
                height: 40.h,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: appTheme.warningBackgroundColor,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(
                  Icons.event_busy,
                  size: 22.sp,
                  color: appTheme.warningColor,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Text(
                  'Mark as Blocked',
                  style: appTheme.valueTextStyle.copyWith(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w600,
                    fontSize: 14.sp,
                  ),
                ),
              ),
              ValueListenableBuilder<bool>(
                valueListenable: isBlockedNotifier,
                builder: (context, isBlocked, _) {
                  return Switch.adaptive(
                    value: isBlocked,
                    onChanged: (v) => isBlockedNotifier.value = v,
                    activeColor: Colors.white,
                    activeTrackColor: appTheme.deepDarkBlueColor,
                  );
                },
              ),
            ],
          ),
          SizedBox(height: 6.h),
          Padding(
            padding: EdgeInsets.only(left: 52.w),
            child: Text(
              'Keep this slot unavailable for booking',
              style: appTheme.captionTextStyle.copyWith(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w400,
                fontSize: 12.sp,
                height: 20 / 12,
                color: appTheme.secondaryTextColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
