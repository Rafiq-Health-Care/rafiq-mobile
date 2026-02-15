import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:rafiq/core/utils/extensions/get_app_theme.dart';

class MedicationCardDetails extends StatelessWidget {
  final String frequency;
  final DateTime? nextReminder;

  const MedicationCardDetails({
    super.key,
    required this.frequency,
    required this.nextReminder,
  });

  String _formatNextDose(DateTime? date) {
    if (date == null) return 'N/A';
    final now = DateTime.now();
    if (date.year == now.year &&
        date.month == now.month &&
        date.day == now.day) {
      return 'Today at ${DateFormat('h:mm a').format(date)}';
    }
    return DateFormat('MMM dd, yyyy').format(date);
  }

  @override
  Widget build(BuildContext context) {
    final appTheme = context.appTheme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Frequency',
              style: TextStyle(color: Colors.grey.shade500, fontSize: 12.sp),
            ),
            const SizedBox(height: 4),
            Text(
              frequency,
              style: appTheme.bodyTextStyle.copyWith(
                color: Colors.black87,
                fontSize: 14.sp,
              ),
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              'Next Dose',
              style: TextStyle(color: Colors.grey.shade500, fontSize: 12.sp),
            ),
            const SizedBox(height: 4),
            Text(
              _formatNextDose(nextReminder),
              style: appTheme.bodyTextStyle.copyWith(
                color: Colors.black87,
                fontSize: 14.sp,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
