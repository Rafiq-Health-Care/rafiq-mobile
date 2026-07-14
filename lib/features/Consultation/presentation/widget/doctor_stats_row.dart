import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rafiq/core/utils/extensions/get_app_theme.dart';
import 'package:rafiq/core/utils/image_url.dart';

class DoctorStatsRow extends StatelessWidget {
  final int yearsOfExperience;
  final double rating;

  const DoctorStatsRow({
    super.key,
    required this.yearsOfExperience,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 20.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildStatItem(
            context,
            iconPath: ImageUrl().work,
            value: '$yearsOfExperience Years',
            label: 'Experience',
          ),
          _buildStatItem(
            context,
            iconPath: ImageUrl().people,
            value: '+200',
            label: 'Patients',
          ),
          _buildStatItem(
            context,
            iconPath: ImageUrl().star,
            value: rating.toStringAsFixed(1),
            label: 'Rating',
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(
    BuildContext context, {
    required String iconPath,
    required String value,
    required String label,
  }) {
    final appTheme = context.appTheme;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: EdgeInsets.all(8.w),
          decoration: BoxDecoration(
            color: appTheme.softBlueColor.withValues(alpha: 0.3),
            shape: BoxShape.circle,
          ),
          child: SvgPicture.asset(
            iconPath,
            colorFilter: ColorFilter.mode(
              appTheme.deepDarkBlueColor,
              BlendMode.srcIn,
            ),
            width: 28.w,
            height: 28.h,
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          value,
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
            fontSize: 13.sp,
            color: appTheme.deepDarkBlueColor,
          ),
        ),
        SizedBox(height: 2.h),
        Text(
          label,
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w400,
            fontSize: 11.sp,
            color: appTheme.greyColor7,
          ),
        ),
      ],
    );
  }
}
