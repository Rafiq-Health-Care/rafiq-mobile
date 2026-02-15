import 'package:flutter/material.dart';
import 'package:rafiq/core/utils/extensions/get_app_theme.dart';

class LabelWithIcon extends StatelessWidget {
  final String label;
  final IconData icon;
  const LabelWithIcon({super.key, required this.label, required this.icon});

  @override
  Widget build(BuildContext context) {
    final appTheme = context.appTheme;
    return Row(
      spacing: 12,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: appTheme.deepDarkBlueColor.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: appTheme.deepDarkBlueColor, size: 20),
        ),
        Text(
          label,
          style: appTheme.bodyLargeTextStyle.copyWith(
            color: appTheme.deepDarkBlueColor,
          ),
        ),
      ],
    );
  }
}
