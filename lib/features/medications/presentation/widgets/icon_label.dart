import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq/core/utils/extensions/get_app_theme.dart';

class IconLabel extends StatelessWidget {
  final String iconPath;
  final String title;
  const IconLabel({super.key, required this.iconPath, required this.title});

  @override
  Widget build(BuildContext context) {
    final appTheme = context.appTheme;
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0, top: 8.0),
      child: Row(
        children: [
          Image.asset(iconPath, width: 28.r),
          const SizedBox(width: 8),
          Text(title, style: appTheme.textFieldLabelTextStyle),
        ],
      ),
    );
  }
}
