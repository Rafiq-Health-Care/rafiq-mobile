import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq/core/utils/extensions/get_app_theme.dart';

/// A tappable, non-editable-by-typing field styled like the app's inputs —
/// used to trigger a date or time picker.
class PickerField extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final VoidCallback onTap;

  const PickerField({
    super.key,
    required this.label,
    required this.value,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final appTheme = context.appTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: appTheme.textFieldLabelTextStyle.copyWith(
            fontFamily: 'Inter',
            fontWeight: FontWeight.w600,
            fontSize: 13.sp,
            height: 20 / 13,
            color: appTheme.labelColor,
          ),
        ),
        SizedBox(height: 8.h),
        Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(16),
            onTap: onTap,
            child: Container(
              height: 46.h,
              padding: EdgeInsets.symmetric(horizontal: 14.w),
              decoration: BoxDecoration(
                color: appTheme.surfaceMutedColor,
                border: Border.all(color: appTheme.borderColor),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  Icon(icon, size: 18.sp, color: appTheme.placeholderColor),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: Text(
                      value,
                      overflow: TextOverflow.ellipsis,
                      style: appTheme.textFieldTextStyle.copyWith(
                        fontFamily: 'Inter',
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: appTheme.inputTextColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
