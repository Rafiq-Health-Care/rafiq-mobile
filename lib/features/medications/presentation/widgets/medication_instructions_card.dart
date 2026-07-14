import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq/core/utils/extensions/get_app_theme.dart';

class MedicationInstructionsCard extends StatelessWidget {
  final String? notes;

  const MedicationInstructionsCard({
    super.key,
    this.notes,
  });

  @override
  Widget build(BuildContext context) {
    final appTheme = context.appTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Instructions",
          style: appTheme.infoLabelTextStyle.copyWith(fontSize: 18.sp),
        ),
        const SizedBox(height: 10),
        Text(
          notes ?? "No instructions provided.",
          style: TextStyle(
            color: appTheme.greyColor6,
            fontWeight: FontWeight.w500,
            fontFamily: 'Inter',
            fontSize: 13.sp,
            height: 1.5,
          ),
        ),
      ],
    );
  }
}
