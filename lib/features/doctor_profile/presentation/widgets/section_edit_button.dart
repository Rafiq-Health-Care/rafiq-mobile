import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq/core/utils/extensions/get_app_theme.dart';

/// The small pencil button shown next to each editable section of a
/// doctor's own profile (basic info, biography, price, ...).
class SectionEditButton extends StatelessWidget {
  final VoidCallback onTap;
  final String? tooltip;

  const SectionEditButton({super.key, required this.onTap, this.tooltip});

  @override
  Widget build(BuildContext context) {
    final appTheme = context.appTheme;
    return Tooltip(
      message: tooltip ?? 'Edit',
      child: InkWell(
        borderRadius: BorderRadius.circular(20.r),
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.all(6.r),
          decoration: BoxDecoration(
            color: appTheme.softBlueColor.withValues(alpha: 0.25),
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.edit_outlined,
            size: 16.r,
            color: appTheme.deepDarkBlueColor,
          ),
        ),
      ),
    );
  }
}

/// The "+ Add experience" affordance shown above the experience timeline.
class AddSectionItemButton extends StatelessWidget {
  final VoidCallback onTap;
  final String label;

  const AddSectionItemButton({
    super.key,
    required this.onTap,
    this.label = 'Add experience',
  });

  @override
  Widget build(BuildContext context) {
    final appTheme = context.appTheme;
    return InkWell(
      borderRadius: BorderRadius.circular(20.r),
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
        decoration: BoxDecoration(
          color: appTheme.softBlueColor.withValues(alpha: 0.25),
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.add_circle_outline,
              size: 16.r,
              color: appTheme.deepDarkBlueColor,
            ),
            SizedBox(width: 4.w),
            Text(
              label,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
                fontSize: 11.sp,
                color: appTheme.deepDarkBlueColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
