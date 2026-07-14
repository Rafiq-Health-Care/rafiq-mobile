import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

/// Pill-shaped "‹  Oct 23 - Oct 29, 2023  ›" navigator.
class WeekDateSelector extends StatelessWidget {
  final DateTime weekStart;
  final DateTime weekEnd;
  final VoidCallback onPrevious;
  final VoidCallback onNext;

  const WeekDateSelector({
    super.key,
    required this.weekStart,
    required this.weekEnd,
    required this.onPrevious,
    required this.onNext,
  });

  String get _label {
    final sameMonth = weekStart.month == weekEnd.month;
    final startFmt = DateFormat(
      sameMonth ? 'MMM d' : 'MMM d',
    ).format(weekStart);
    final endFmt = DateFormat(
      sameMonth ? 'd, yyyy' : 'MMM d, yyyy',
    ).format(weekEnd);
    return '$startFmt - $endFmt';
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(28.r),
          border: Border.all(color: Color(0xFFE3E8EF)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _NavButton(icon: Icons.chevron_left, onTap: onPrevious),
            SizedBox(width: 12.w),
            Text(
              _label,
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w700,
                color: Color(0xFF0B1B3A),
              ),
            ),
            SizedBox(width: 12.w),
            _NavButton(icon: Icons.chevron_right, onTap: onNext),
          ],
        ),
      ),
    );
  }
}

class _NavButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _NavButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(20.r),
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.all(6.r),
        child: Icon(icon, size: 22.sp, color: Color(0xFF0B1B3A)),
      ),
    );
  }
}
