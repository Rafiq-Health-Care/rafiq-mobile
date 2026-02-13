import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq/core/theme/app_theme.dart';

class InfoRowWidget extends StatelessWidget {
  final String label;
  final String value;
  const InfoRowWidget({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    final appTheme = Theme.of(context).extension<AppTheme>()!;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 32.w,
        children: [
          Text(label, style: appTheme.infoLabelTextStyle),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                color: appTheme.greyColor6,
                fontWeight: FontWeight.w500,
                fontFamily: 'Inter',
                fontSize: 14.sp,
              ),
              maxLines: 2,
              textAlign: TextAlign.end,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
