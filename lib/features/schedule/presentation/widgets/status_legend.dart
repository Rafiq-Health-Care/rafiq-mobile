import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq/features/schedule/domain/entities/slot_status.dart';

/// "SESSION STATUS:" pill with a colored dot + label per [SlotStatus].
/// Uses [Wrap] so it degrades gracefully on narrow screens.
class StatusLegend extends StatelessWidget {
  const StatusLegend({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28.r),
        border: Border.all(color: Color(0xFFE3E8EF)),
      ),
      child: Wrap(
        spacing: 20.w,
        runSpacing: 10.h,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Text(
            'SESSION STATUS:',
            style: TextStyle(
              fontSize: 13.sp,
              fontWeight: FontWeight.w700,
              color: Color(0xFF6B7280),
              letterSpacing: 0.5,
            ),
          ),
          for (final status in SlotStatus.values) _LegendItem(status: status),
        ],
      ),
    );
  }
}

class _LegendItem extends StatelessWidget {
  final SlotStatus status;

  const _LegendItem({required this.status});

  @override
  Widget build(BuildContext context) {
    final isOutline = status == SlotStatus.available;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 14.r,
          height: 14.r,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isOutline ? Colors.white : status.color,
            border: Border.all(
              color: isOutline ? Color(0xFF7FD4AE) : status.color,
              width: 2,
            ),
          ),
        ),
        SizedBox(width: 8.w),
        Text(
          status.label,
          style: TextStyle(
            fontSize: 15.sp,
            fontWeight: FontWeight.w600,
            color: Color(0xFF0B1B3A),
          ),
        ),
      ],
    );
  }
}
