import 'package:flutter/material.dart';
import 'package:rafiq/core/utils/extensions/get_app_theme.dart';

class HomeMenuItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const HomeMenuItem({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final appTheme = context.appTheme;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Row(
        spacing: 16,
        children: [
          Icon(icon, size: 24, color: appTheme.greyColor6),
          Expanded(child: Text(label, style: appTheme.drawerLabelTextStyle)),
        ],
      ),
    );
  }
}
