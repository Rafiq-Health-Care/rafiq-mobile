import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq/core/utils/extensions/get_app_theme.dart';

class SessionReasonField extends StatelessWidget {
  final ValueNotifier<bool> isBlockedNotifier;
  final TextEditingController controller;

  const SessionReasonField({
    super.key,
    required this.isBlockedNotifier,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final appTheme = context.appTheme;
    return ValueListenableBuilder<bool>(
      valueListenable: isBlockedNotifier,
      builder: (context, isBlocked, _) {
        if (!isBlocked) return const SizedBox.shrink();
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Reason for Blocking',
              style: appTheme.textFieldLabelTextStyle.copyWith(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w600,
                fontSize: 14.sp,
                height: 20 / 14,
                color: appTheme.labelColor,
              ),
            ),
            SizedBox(height: 8.h),
            Container(
              height: 94.h,
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
              decoration: BoxDecoration(
                color: appTheme.surfaceMutedColor,
                border: Border.all(color: appTheme.borderColor),
                borderRadius: BorderRadius.circular(16),
              ),
              child: TextField(
                controller: controller,
                maxLines: null,
                expands: true,
                textAlignVertical: TextAlignVertical.top,
                style: appTheme.textFieldTextStyle.copyWith(
                  fontFamily: 'Inter',
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: appTheme.inputTextColor,
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'e.g. Hospital Rounds, Personal Break...',
                  hintStyle: appTheme.textFieldHintTextStyle.copyWith(
                    fontFamily: 'Inter',
                    fontSize: 14.sp,
                    color: appTheme.placeholderColor,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
