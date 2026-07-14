// cancellation_reason_card.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq/core/utils/extensions/get_app_theme.dart';
import '../../domain/entities/consultation.dart';

class CancellationReasonCard extends StatelessWidget {
  final Consultation consultation;
  const CancellationReasonCard({super.key, required this.consultation});

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    final submittedBy = consultation.cancelByPatient ? consultation.patient.fullName : 'the clinic';

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: theme.accentRedColor.withOpacity(0.04),
        borderRadius: BorderRadius.circular(12.r),
        border: Border(left: BorderSide(color: theme.accentRedColor.withOpacity(0.6), width: 4.w)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('CANCELLATION REASON', style: theme.overlineTextStyle.copyWith(color: theme.accentRedColor)),
          SizedBox(height: 12.h),
          Text('"${consultation.reason}"', style: theme.captionTextStyle.copyWith(color: theme.greyColor6)),
          SizedBox(height: 8.h),
          Text('— Submitted by $submittedBy', style: theme.descriptionSmallTextStyle),
        ],
      ),
    );
  }
}