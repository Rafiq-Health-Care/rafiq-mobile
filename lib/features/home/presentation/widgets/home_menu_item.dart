import 'package:flutter/material.dart';
import 'package:rafiq/core/utils/extensions/get_app_theme.dart';

class HomeMenuItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool isSelected;

  const HomeMenuItem({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    final appTheme = context.appTheme;
    return Material(
      color: isSelected
          ? appTheme.accentBlueColor.withValues(alpha: 0.08)
          : Colors.transparent,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
          child: Row(
            spacing: 16,
            children: [
              Icon(
                icon,
                size: 24,
                color: isSelected
                    ? appTheme.accentBlueColor
                    : appTheme.greyColor6,
              ),
              Expanded(
                child: Text(
                  label,
                  style: appTheme.drawerLabelTextStyle.copyWith(
                    color: isSelected
                        ? appTheme.accentBlueColor
                        : appTheme.greyColor6,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}