import 'package:flutter/material.dart';
import 'package:rafiq/core/utils/extensions/get_app_theme.dart';

class CustomIconButton extends StatelessWidget {
  final VoidCallback onPress;
  final String label;
  final IconData icon;
  final double borderRadius;
  final Color? labelColor;
  final double? fontSize;
  final Color? backgroundColor;

  const CustomIconButton({
    super.key,
    required this.onPress,
    required this.label,
    required this.icon,
    this.borderRadius = 12,
    this.labelColor,
    this.fontSize,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final appTheme = context.appTheme;
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: ElevatedButton.icon(
        onPressed: onPress,
        icon: Icon(icon, color: labelColor ?? appTheme.deepDarkBlueColor),
        label: Text(
          label,
          style: appTheme.buttonLabelTextStyle.copyWith(
            color: labelColor ?? appTheme.deepDarkBlueColor,
            fontSize: fontSize,
          ),
        ),
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16),
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
      ),
    );
  }
}
