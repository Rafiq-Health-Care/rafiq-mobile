// pre_consultation_notes_card.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq/core/utils/extensions/get_app_theme.dart';

class PreConsultationNotesCard extends StatelessWidget {
  final String notes;
  const PreConsultationNotesCard({super.key, required this.notes});

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: theme.surfaceMutedColor,
        borderRadius: BorderRadius.circular(12.r),
        border: Border(left: BorderSide(color: theme.deepDarkBlueColor, width: 4.w)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('PRE-CONSULTATION NOTES', style: theme.overlineTextStyle),
          SizedBox(height: 8.h),
          Text('"$notes"', style: theme.captionTextStyle),
        ],
      ),
    );
  }
}