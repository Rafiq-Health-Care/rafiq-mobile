import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq/core/utils/extensions/get_app_theme.dart';
import 'package:rafiq/core/utils/extensions/size_extension.dart';
import 'package:rafiq/features/doctor_discovery/presentation/widget/doctor_stats_row.dart';
import 'package:rafiq/features/doctor_profile/presentation/widgets/section_edit_button.dart';

class DoctorDetailsHeader extends StatelessWidget {
  final String? image;
  final String name;
  final String specialization;
  final int yearOfExperience;
  final int patientsCount;
  final double rating;
  final VoidCallback? onEditTap;

  const DoctorDetailsHeader({
    super.key,
    this.image,
    required this.name,
    required this.specialization,
    required this.yearOfExperience,
    required this.patientsCount,
    required this.rating,
    this.onEditTap,
  });

  @override
  Widget build(BuildContext context) {
    final appTheme = context.appTheme;
    return Container(
      width: context.width,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            const Color(0xff8FA4FF).withValues(alpha: 0.3),
            appTheme.surfaceColor,
          ],
          stops: const [0.0, .75],
        ),
      ),
      child: Column(
        children: [
          SizedBox(
            height: 275.h,
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.w),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Flexible(
                              child: Text(
                                'Dr. $name',
                                style: appTheme.headingTextStyle.copyWith(
                                  fontSize: 22.sp,
                                  fontWeight: FontWeight.w700,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            if (onEditTap != null) ...[
                              SizedBox(width: 6.w),
                              SectionEditButton(
                                tooltip: 'Edit basic info',
                                onTap: onEditTap!,
                              ),
                            ],
                          ],
                        ),
                        SizedBox(height: 12.h),
                        Text(
                          specialization,
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,
                            fontSize: 13.sp,
                            color: appTheme.accentBlueColor,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
                if (image != null && image!.isNotEmpty)
                  Expanded(
                    child: CachedNetworkImage(
                      imageUrl: image!,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Center(
                        child: CircularProgressIndicator(
                          color: appTheme.deepDarkBlueColor,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          Transform.translate(
            offset: Offset(0, -15.h),
            child: DoctorStatsRow(
              yearsOfExperience: yearOfExperience,
              patientsCount: patientsCount,
              rating: rating,
            ),
          ),
        ],
      ),
    );
  }
}
