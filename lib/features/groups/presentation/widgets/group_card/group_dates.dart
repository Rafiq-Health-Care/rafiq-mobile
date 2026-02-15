import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:rafiq/core/utils/extensions/get_app_theme.dart';
import 'package:rafiq/features/groups/data/models/group_content_model.dart';

class GroupDates extends StatelessWidget {
  final GroupContentModel group;
  const GroupDates({super.key, required this.group});

  @override
  Widget build(BuildContext context) {
    final appTheme = context.appTheme;
    final dateFormat = DateFormat('yyyy-MM-dd');
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Created at: ${dateFormat.format(group.createdAt)}',
          style: TextStyle(
            color: appTheme.greyColor4,
            fontSize: 11.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          'Last Update: ${dateFormat.format(group.updatedAt)}',
          style: TextStyle(
            color: appTheme.greyColor4,
            fontSize: 11.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
