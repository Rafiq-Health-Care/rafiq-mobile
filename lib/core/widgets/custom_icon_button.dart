import 'package:flutter/material.dart';
import 'package:rafiq/core/theme/app_theme.dart';

class CustomIconButton extends StatelessWidget {
  final VoidCallback onPress;
  final String label;
  final IconData icon;
  final double borderRadius;

  const CustomIconButton({
    super.key,
    required this.onPress,
    required this.label,
    required this.icon,
    this.borderRadius = 12,
  });

  @override
  Widget build(BuildContext context) {
    final appTheme = Theme.of(context).extension<AppTheme>()!;
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: ElevatedButton.icon(
        onPressed: onPress,
        icon: Icon(icon, color: appTheme.deepDarkBlueColor),
        label: Text(
          label,
          style: appTheme.buttonLabelTextStyle.copyWith(
            color: appTheme.deepDarkBlueColor,
          ),
        ),
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
      ),
    );
  }
}
