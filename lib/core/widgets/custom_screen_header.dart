import 'package:flutter/material.dart';
import 'package:rafiq/core/theme/app_theme.dart';

class CustomScreenHeader extends StatelessWidget {
  final String title;
  final String description;
  final int total;

  const CustomScreenHeader({
    super.key,
    required this.title,
    required this.description,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    final appTheme = Theme.of(context).extension<AppTheme>()!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: appTheme.headingTextStyle.copyWith(fontSize: 24),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Text(
                'Total Medicines : $total',
                style: TextStyle(
                  color: Colors.blue.shade400,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          description,
          style: appTheme.descriptionSmallTextStyle.copyWith(
            fontSize: 14,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}
