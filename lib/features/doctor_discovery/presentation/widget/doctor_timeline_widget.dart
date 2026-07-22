import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rafiq/core/utils/extensions/get_app_theme.dart';
import 'package:rafiq/features/doctor_profile/presentation/widgets/section_edit_button.dart';

class TimelineItemData {
  final String title;
  final String subtitle;
  final String? description;
  final String years;

  TimelineItemData({
    required this.title,
    required this.subtitle,
    this.description,
    required this.years,
  });
}

class DoctorTimelineWidget extends StatelessWidget {
  final List<TimelineItemData> items;
  final String iconPath;
  final VoidCallback? onAddTap;
  final ValueChanged<int>? onEditItem;
  final String addLabel;

  const DoctorTimelineWidget({
    super.key,
    required this.items,
    required this.iconPath,
    this.onAddTap,
    this.onEditItem,
    this.addLabel = 'Add experience',
  });

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 24.h),
        child: Column(
          children: [
            if (onAddTap != null) ...[
              Align(
                alignment: Alignment.centerRight,
                child: AddSectionItemButton(
                  label: addLabel,
                  onTap: onAddTap!,
                ),
              ),
              SizedBox(height: 12.h),
            ],
            Center(
              child: Text(
                'No items available',
                style: TextStyle(
                  fontSize: 13.sp,
                  color: context.appTheme.greyColor7,
                ),
              ),
            ),
          ],
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (onAddTap != null) ...[
          Align(
            alignment: Alignment.centerRight,
            child: AddSectionItemButton(label: addLabel, onTap: onAddTap!),
          ),
          SizedBox(height: 12.h),
        ],
        _TimelineList(
          items: items,
          iconPath: iconPath,
          onEditItem: onEditItem,
        ),
      ],
    );
  }
}

class _TimelineList extends StatelessWidget {
  final List<TimelineItemData> items;
  final String iconPath;
  final ValueChanged<int>? onEditItem;

  const _TimelineList({
    required this.items,
    required this.iconPath,
    required this.onEditItem,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        final isLast = index == items.length - 1;

        return IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Left side timeline graphic
              Column(
                children: [
                  CircleAvatar(
                    radius: 20.r,
                    backgroundColor: context.appTheme.softBlueColor.withValues(
                      alpha: 0.4,
                    ),
                    child: SvgPicture.asset(
                      iconPath,
                      width: 20.r,
                      height: 20.r,
                      colorFilter: ColorFilter.mode(
                        context.appTheme.deepDarkBlueColor,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                  if (!isLast)
                    Expanded(
                      child: Container(
                        width: 2.w,
                        color: context.appTheme.greyColor4.withValues(
                          alpha: 0.5,
                        ),
                      ),
                    ),
                ],
              ),
              SizedBox(width: 16.w),
              // Right side details card
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(bottom: 24.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              item.title,
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w700,
                                fontSize: 14.sp,
                                color: const Color(0xff1E293B),
                              ),
                            ),
                          ),
                          if (onEditItem != null)
                            SectionEditButton(
                              tooltip: 'Edit experience',
                              onTap: () => onEditItem!(index),
                            ),
                        ],
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        '${item.subtitle}  •  ${item.years}',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w500,
                          fontSize: 12.sp,
                          color: const Color(0xff0097B2),
                        ),
                      ),
                      if (item.description != null &&
                          item.description!.isNotEmpty) ...[
                        SizedBox(height: 8.h),
                        Text(
                          item.description!,
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w400,
                            fontSize: 11.sp,
                            color: const Color(0xff64748B),
                            height: 1.5,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
