// action_buttons.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq/core/utils/extensions/get_app_theme.dart';

class PrimaryActionButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback? onPressed;
  final bool loading;

  const PrimaryActionButton({
    super.key,
    required this.label,
    required this.icon,
    required this.onPressed,
    this.loading = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;

    return SizedBox(
      width: double.infinity,
      height: 52.h,
      child: ElevatedButton(
        onPressed: loading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: theme.deepDarkBlueColor,
          disabledBackgroundColor: theme.deepDarkBlueColor.withOpacity(0.6),
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
        ),
        child: loading
            ? SizedBox(
                width: 20.w,
                height: 20.w,
                child: CircularProgressIndicator(strokeWidth: 2, color: theme.surfaceColor),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(icon, size: 17.sp, color: theme.surfaceColor),
                  SizedBox(width: 8.w),
                  Text(label, style: theme.buttonLabelTextStyle),
                ],
              ),
      ),
    );
  }
}

class DangerOutlineButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback? onPressed;
  final bool loading;

  const DangerOutlineButton({
    super.key,
    required this.label,
    required this.icon,
    required this.onPressed,
    this.loading = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;

    return SizedBox(
      width: double.infinity,
      height: 52.h,
      child: OutlinedButton(
        onPressed: loading ? null : onPressed,
        style: OutlinedButton.styleFrom(
          backgroundColor: theme.surfaceColor,
          side: BorderSide(color: theme.accentRedColor),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
        ),
        child: loading
            ? SizedBox(
                width: 20.w,
                height: 20.w,
                child: CircularProgressIndicator(strokeWidth: 2, color: theme.accentRedColor),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(icon, size: 15.sp, color: theme.accentRedColor),
                  SizedBox(width: 8.w),
                  Text(label, style: theme.buttonLabelTextStyle.copyWith(color: theme.accentRedColor)),
                ],
              ),
      ),
    );
  }
}