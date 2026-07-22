import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:rafiq/core/utils/extensions/get_app_theme.dart';
import 'package:rafiq/features/doctor_discovery/domain/entity/doctor_entity.dart';

class DoctorCardWidget extends StatelessWidget {
  final DoctorEntity doctor;
  final VoidCallback onBookTap;

  const DoctorCardWidget({
    super.key,
    required this.doctor,
    required this.onBookTap,
  });

  @override
  Widget build(BuildContext context) {
    final appTheme = context.appTheme;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: appTheme.surfaceColor,
        border: Border.all(color: appTheme.greyColor4, width: 1),
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 8.r,
            offset: Offset(0, 4.h),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Doctor photo with online indicator stack
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(50.r),
                    child:
                        doctor.personalPhoto != null &&
                            doctor.personalPhoto!.isNotEmpty
                        ? Image.network(
                            doctor.personalPhoto!,
                            width: 54.w,
                            height: 54.h,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                const DefaultDoctorAvatar(),
                          )
                        : const DefaultDoctorAvatar(),
                  ),
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Container(
                      width: 14.w,
                      height: 14.h,
                      decoration: BoxDecoration(
                        color: appTheme.accentGreenColor,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2.w),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(width: 12.w),
              // Doctor details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Dr. ${doctor.firstName} ${doctor.lastName}',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                            fontSize: 14.sp,
                            color: appTheme.deepDarkBlueColor,
                          ),
                        ),
                        // Rating
                        Row(
                          children: [
                            Icon(
                              Icons.star,
                              color: const Color(0xffF6CB05),
                              size: 16.sp,
                            ),
                            SizedBox(width: 4.w),
                            Text(
                              doctor.rating.toStringAsFixed(1),
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w500,
                                fontSize: 12.sp,
                                color: appTheme.greyColor6,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      '${doctor.specialization}  •  ${doctor.yearsOfExperience}y exp.',
                      style: appTheme.descriptionSmallTextStyle.copyWith(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        color: appTheme.greyColor7,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    // Location / Clinic
                    Row(
                      children: [
                        Icon(
                          Icons.location_on_outlined,
                          color: appTheme.greyColor7,
                          size: 16.sp,
                        ),
                        SizedBox(width: 4.w),
                        Expanded(
                          child: Text(
                            'Online Consultation',
                            overflow: TextOverflow.ellipsis,
                            style: appTheme.descriptionSmallTextStyle.copyWith(
                              fontSize: 11.sp,
                              color: appTheme.greyColor7,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          // Availability
          Text(
            'Available ${DateFormat('EEEE, MMMM d, h:mm a').format(doctor.nextAvailable)}',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w500,
              fontSize: 12.sp,
              color: appTheme.accentGreenColor,
            ),
          ),
          Divider(height: 16.h, color: appTheme.fieldFillColor),
          // Price and Book button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RichText(
                text: TextSpan(
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 14.sp,
                    color: appTheme.deepDarkBlueColor,
                  ),
                  children: [
                    TextSpan(
                      text: 'EGP ${doctor.price.toStringAsFixed(0)} ',
                      style: const TextStyle(fontWeight: FontWeight.w700),
                    ),
                    TextSpan(
                      text: 'consulting fee',
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: appTheme.greyColor7,
                        fontSize: 11.sp,
                      ),
                    ),
                  ],
                ),
              ),
              ElevatedButton.icon(
                onPressed: onBookTap,
                style: ElevatedButton.styleFrom(
                  backgroundColor: appTheme.deepDarkBlueColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40.r),
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 8.h,
                  ),
                  elevation: 0,
                ),
                icon: Icon(
                  Icons.calendar_today_outlined,
                  size: 16.sp,
                  color: Colors.white,
                ),
                label: Text(
                  'Book Now',
                  style: appTheme.buttonLabelTextStyle.copyWith(
                    fontSize: 13.sp,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class DefaultDoctorAvatar extends StatelessWidget {
  const DefaultDoctorAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    final appTheme = context.appTheme;
    return Container(
      width: 54.w,
      height: 54.h,
      color: const Color(0xffE0CEFF),
      child: Icon(Icons.person, size: 32.sp, color: appTheme.deepDarkBlueColor),
    );
  }
}
