import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq/core/utils/extensions/get_app_theme.dart';

class CustomScreenHeader extends StatelessWidget {
  final String title;
  final String description;
  final String? total;

  const CustomScreenHeader({
    super.key,
    required this.title,
    required this.description,
    this.total,
  });

  @override
  Widget build(BuildContext context) {
    final appTheme = context.appTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: appTheme.headingTextStyle.copyWith(
                fontSize: 24.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
            if (total != null)
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  total!,
                  style: TextStyle(
                    color: Colors.blue.shade400,
                    fontWeight: FontWeight.w700,
                    fontSize: 13.sp,
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          description,
          style: appTheme.descriptionSmallTextStyle.copyWith(
            fontSize: 13.sp,
            fontWeight: FontWeight.w400,
          ),
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
        ),
      ],
    );
  }
}
