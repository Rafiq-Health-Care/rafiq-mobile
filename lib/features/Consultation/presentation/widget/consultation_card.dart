import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:rafiq/core/router/router_strings.dart';
import 'package:rafiq/core/utils/extensions/get_app_theme.dart';
import 'package:rafiq/core/utils/extensions/navigation_extension.dart';
import 'package:rafiq/features/Consultation/domain/entity/consultation_entity.dart';
import 'package:rafiq/features/Consultation/presentation/controller/consultation_cubit/consultation_cubit.dart';
import 'package:rafiq/features/Consultation/presentation/dialog/cancel_consultation_dialog.dart';

class ConsultationCard extends StatelessWidget {
  final ConsultationEntity consultation;

  const ConsultationCard({super.key, required this.consultation});

  @override
  Widget build(BuildContext context) {
    final appTheme = context.appTheme;
    return InkWell(
      onTap: () {
        context.navigateTo(
          RouterStrings.consultationDetails,
          arguments: consultation.consultationId,
        );
      },
      child: Container(
        // Appointment Card
        padding: EdgeInsets.all(16.r),
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xffDCDCDC)),
          borderRadius: BorderRadius.circular(24.r),
        ),
        child: Column(
          spacing: 16.h,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Appointment Details
            Column(
              spacing: 16.h,
              children: [
                // Doctor Info Row
                Row(
                  spacing: 8.w,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Doctor Image
                    Container(
                      width: 64.r,
                      height: 64.r,
                      decoration: BoxDecoration(
                        color: appTheme.deepDarkBlueColor.withValues(
                          alpha: .25,
                        ),
                        shape: BoxShape.circle,
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50.r),
                        child: CachedNetworkImage(
                          imageUrl: consultation.doctorImage,
                          width: 64.r,
                          height: 64.r,
                          fit: BoxFit.cover,
                          placeholder: (_, __) => const Center(
                            child: CircularProgressIndicator(strokeWidth: 2),
                          ),
                          errorWidget: (_, _, _) => CircleAvatar(
                            radius: 32.r,
                            backgroundColor: const Color(0xFFDCDCDC),
                            child: Icon(
                              Icons.person,
                              size: 30.r,
                              color: const Color(0xFF575757),
                            ),
                          ),
                        ),
                      ),
                    ),

                    // Doctor Details
                    Expanded(
                      child: Column(
                        spacing: 4.h,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Doctor Name and Reminder
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Dr.${consultation.doctorName}',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14.sp,
                                  color: const Color(0xff101010),
                                ),
                              ),
                            ],
                          ),
                          // Specialty
                          Text(
                            consultation.doctorBio,
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400,
                              fontSize: 12.sp,
                              color: const Color(0xff575757),
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                // Appointment Time Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Date Info
                    Row(
                      spacing: 4.w,
                      children: [
                        Icon(
                          Icons.calendar_month_outlined,
                          size: 16.r,
                          color: const Color(0xff575757),
                        ),
                        Text(
                          DateFormat(
                            'EEEE, MMMM d',
                          ).format(consultation.startTime),
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,
                            fontSize: 14.sp,
                            color: const Color(0xff575757),
                          ),
                        ),
                      ],
                    ),
                    // Time Info
                    Row(
                      spacing: 4.w,
                      children: [
                        Icon(
                          Icons.access_time,
                          size: 16.r,
                          color: const Color(0xff575757),
                        ),
                        Text(
                          DateFormat('hh:mm a').format(consultation.startTime),
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,
                            fontSize: 14.sp,
                            color: const Color(0xff575757),
                          ),
                        ),
                      ],
                    ),
                    // Status Info
                    Row(
                      spacing: 4.w,
                      children: [
                        Container(
                          width: 6.r,
                          height: 6.r,
                          decoration: const BoxDecoration(
                            color: Color(0xff1CDA30),
                            shape: BoxShape.circle,
                          ),
                        ),
                        Text(
                          "${consultation.duration} min",
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,
                            fontSize: 14.sp,
                            color: const Color(0xff575757),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),

            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 40.h,
                    child: OutlinedButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (_) => CancelConsultationDialog(
                            doctorName: consultation.doctorName,
                            consultationDate: consultation.startTime,
                            onCancel: () => context
                                .read<ConsultationCubit>()
                                .cancelConsultation(
                                  consultationId:
                                      consultation.consultationId,
                                  reason: "<I want to cancel this consultation>",
                                ),
                          ),
                        );
                      },
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: appTheme.accentBlueColor),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40.r),
                        ),
                      ),
                      child: Text(
                        "Cancel",
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                          fontSize: 14.sp,
                          color: appTheme.accentBlueColor,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 12.w), // Preserved layout scaling gap
                Expanded(
                  child: SizedBox(
                    height: 40.h,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: appTheme.deepDarkBlueColor,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40.r),
                        ),
                      ),
                      child: Text(
                        "join",
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                          fontSize: 14.sp,
                          color: const Color(0xffFFFFFF),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
