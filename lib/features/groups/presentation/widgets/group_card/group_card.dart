import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq/core/router/router_strings.dart';
import 'package:rafiq/core/theme/app_theme.dart';
import 'package:rafiq/features/groups/data/models/group_content_model.dart';
import 'package:rafiq/features/groups/presentation/widgets/group_card/group_actions.dart';
import 'package:rafiq/features/groups/presentation/widgets/group_card/group_dates.dart';
import 'package:rafiq/features/groups/presentation/widgets/group_card/group_header.dart';

class GroupCard extends StatelessWidget {
  final GroupContentModel group;
  const GroupCard({super.key, required this.group});

  @override
  Widget build(BuildContext context) {
    final appTheme = Theme.of(context).extension<AppTheme>()!;
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          RouterStrings.groupDetails,
          arguments: group.id,
        );
      },
      child: Container(
        height: 150.h,
        decoration: BoxDecoration(
          color: appTheme.surfaceColor,
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(color: appTheme.greyColor4),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              height: 150.h,
              width: 30.w,
              decoration: BoxDecoration(
                color: appTheme.softBlueColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(14.r),
                  bottomLeft: Radius.circular(14.r),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GroupHeader(group: group),
                    Text(
                      group.description,
                      style: appTheme.descriptionSmallTextStyle.copyWith(
                        color: appTheme.greyColor7,
                        fontWeight: FontWeight.w400,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    GroupDates(group: group),
                    GroupActions(group: group),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
