import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq/core/utils/extensions/get_app_theme.dart';
import 'package:rafiq/features/doctor_profile/presentation/widgets/section_edit_button.dart';

class DoctorInfoSection extends StatelessWidget {
  final String title;
  final String content;
  final VoidCallback? onEditTap;

  const DoctorInfoSection({
    super.key,
    required this.title,
    required this.content,
    this.onEditTap,
  });

  @override
  Widget build(BuildContext context) {
    final appTheme = context.appTheme;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: appTheme.headingTextStyle.copyWith(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              if (onEditTap != null)
                SectionEditButton(
                  tooltip: 'Edit biography',
                  onTap: onEditTap!,
                ),
            ],
          ),
          SizedBox(height: 8.h),
          Text(
            content,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w400,
              fontSize: 12.sp,
              color: appTheme.greyColor7,
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }
}
