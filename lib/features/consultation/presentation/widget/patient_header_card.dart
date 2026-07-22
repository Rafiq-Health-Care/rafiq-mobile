// patient_header_card.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq/core/utils/extensions/get_app_theme.dart';
import 'package:rafiq/features/consultation/domain/entity/doctor_consultation_entity.dart';
import 'package:rafiq/features/consultation/presentation/widget/status_badge.dart';

class PatientHeaderCard extends StatelessWidget {
  final DoctorConsultationEntity consultation;
  final String? contactLine;
  const PatientHeaderCard({super.key, required this.consultation, this.contactLine});

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    final patient = consultation.patient;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: theme.surfaceMutedColor,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 64.w,
            height: 64.w,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: theme.avatarBackgroundColor,
              shape: BoxShape.circle,
              border: Border.all(color: theme.surfaceColor, width: 2),
              boxShadow: [
                BoxShadow(color: Colors.black.withOpacity(0.05), offset: const Offset(0, 1), blurRadius: 2),
              ],
            ),
            child: Text(
              patient.initials,
              style: theme.headingTextStyle.copyWith(fontSize: 20.sp, color: theme.accentBlueColor),
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('PATIENT', style: theme.overlineTextStyle.copyWith(color: theme.accentBlueColor)),
                SizedBox(height: 4.h),
                Text(
                  patient.fullName,
                  style: theme.headingTextStyle.copyWith(fontSize: 20.sp),
                  overflow: TextOverflow.ellipsis,
                ),
                if (contactLine != null) ...[
                  SizedBox(height: 4.h),
                  Text(contactLine!, style: theme.captionTextStyle, overflow: TextOverflow.ellipsis),
                ],
              ],
            ),
          ),
          SizedBox(width: 8.w),
          StatusBadge(consultation: consultation),
        ],
      ),
    );
  }
}