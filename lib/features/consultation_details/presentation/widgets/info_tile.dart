// info_tile.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq/core/utils/extensions/get_app_theme.dart';

class InfoTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final bool muted;

  const InfoTile({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    this.muted = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 36.w,
          height: 36.w,
          padding: EdgeInsets.all(8.w),
          decoration: BoxDecoration(
            color: theme.iconContainerColor,
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Icon(
            icon,
            size: 18.sp,
            color: muted ? theme.greyColor7 : theme.accentBlueColor,
          ),
        ),
        SizedBox(width: 12.w),
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(label, style: theme.overlineTextStyle),
              Text(value, style: theme.valueTextStyle, overflow: TextOverflow.ellipsis),
            ],
          ),
        ),
      ],
    );
  }
}