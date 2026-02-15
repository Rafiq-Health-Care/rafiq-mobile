import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq/core/theme/app_theme.dart';
import 'package:rafiq/features/groups/data/models/group_content_model.dart';

class GroupHeader extends StatelessWidget {
  final GroupContentModel group;
  const GroupHeader({super.key, required this.group});

  @override
  Widget build(BuildContext context) {
    final appTheme = Theme.of(context).extension<AppTheme>()!;
    return Row(
      spacing: 12.w,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            group.name,
            style: appTheme.headingTextStyle.copyWith(fontSize: 18.sp),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Text(
          '${group.medicineCount} Medicines',
          style: TextStyle(
            fontSize: 13.sp,
            fontWeight: FontWeight.w700,
            color: appTheme.greyColor6,
          ),
        ),
      ],
    );
  }
}
