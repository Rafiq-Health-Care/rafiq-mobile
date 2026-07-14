import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Top bar: "Weekly Schedule" title + "Add Session" pill button.
/// Wraps on narrow screens instead of overflowing.
class ScheduleHeader extends StatelessWidget {
  final VoidCallback onAddSession;

  const ScheduleHeader({super.key, required this.onAddSession});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 16.w,
      runSpacing: 12.h,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Text(
          'Weekly Schedule',
          style: TextStyle(
            fontSize: 32.sp,
            fontWeight: FontWeight.w800,
            color: Color(0xFF0B1B3A),
          ),
        ),
        ElevatedButton.icon(
          onPressed: onAddSession,
          icon: Icon(Icons.add, size: 18.sp, color: Colors.white),
          label: Text(
            'Add Session',
            style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w600),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFF0B1F4D),
            foregroundColor: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 14.h),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(28.r),
            ),
            elevation: 0,
          ),
        ),
      ],
    );
  }
}
