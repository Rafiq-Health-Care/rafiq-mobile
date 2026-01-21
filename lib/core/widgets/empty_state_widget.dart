import 'package:flutter/material.dart';
import 'package:rafiq/core/theme/app_theme.dart';

class EmptyStateWidget extends StatelessWidget {
  final Widget icon;
  final String title;
  final String description;
  final Color? titleColor;
  final Color? descriptionColor;

  const EmptyStateWidget({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
    this.titleColor,
    this.descriptionColor,
  });

  @override
  Widget build(BuildContext context) {
    final appTheme = Theme.of(context).extension<AppTheme>()!;

    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon,
            const SizedBox(height: 16),
            Text(
              title,
              style: appTheme.headingTextStyle.copyWith(
                fontSize: 24,
                color: titleColor,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              description,
              style: appTheme.descriptionSmallTextStyle.copyWith(
                color: descriptionColor,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
