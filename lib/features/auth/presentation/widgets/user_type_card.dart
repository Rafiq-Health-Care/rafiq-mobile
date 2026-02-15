import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rafiq/core/utils/extensions/get_app_theme.dart';

class UserTypeCard extends StatelessWidget {
  final String label;
  final String imagePath;
  final Color color;
  final Color contentColor;
  final VoidCallback onTap;

  const UserTypeCard({
    super.key,
    required this.label,
    required this.imagePath,
    required this.color,
    required this.contentColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final appTheme = context.appTheme;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.all(36),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: color,
          border: Border.all(color: appTheme.deepDarkBlueColor, width: 2),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: const Color(0x13000000),
              blurRadius: 15,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          spacing: 8,
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(imagePath, height: 60, width: 60),
            Text(
              label,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                fontFamily: 'Inter',
                color: contentColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
