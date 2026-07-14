import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:rafiq/features/schedule/domain/entities/slot_entity.dart';
import 'package:rafiq/features/schedule/presentation/widgets/slot_card.dart';

/// One vertical day column: "MON / 23" header, then the slots for that day
/// stacked, or a "Weekend - No Sessions" placeholder.
class DayColumn extends StatelessWidget {
  final ScheduleDay day;
  final double width;
  final void Function(SlotEntity slot)? onJoinCall;
  final void Function(SlotEntity slot)? onSlotTap;

  const DayColumn({
    super.key,
    required this.day,
    required this.width,
    this.onJoinCall,
    this.onSlotTap,
  });

  bool get _isToday {
    final now = DateTime.now();
    return day.date.year == now.year &&
        day.date.month == now.month &&
        day.date.day == now.day;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      margin: EdgeInsets.symmetric(horizontal: 6.w),
      padding: EdgeInsets.symmetric(vertical: 10.h),
      decoration: BoxDecoration(
        color: _isToday ? Color(0xFFEFF6FB) : Colors.transparent,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _DayHeader(date: day.date, isToday: _isToday),
          SizedBox(height: 16.h),
          if (day.isWeekend && day.slots.isEmpty)
            const _WeekendPlaceholder()
          else
            for (final slot in day.slots)
              SlotCard(
                slot: slot,
                onJoinCall: () => onJoinCall?.call(slot),
                onTap: () => onSlotTap?.call(slot),
              ),
        ],
      ),
    );
  }
}

class _DayHeader extends StatelessWidget {
  final DateTime date;
  final bool isToday;

  const _DayHeader({required this.date, required this.isToday});

  @override
  Widget build(BuildContext context) {
    final dayLabel = DateFormat('EEE').format(date).toUpperCase();
    return Column(
      children: [
        Text(
          dayLabel,
          style: TextStyle(
            fontSize: 13.sp,
            fontWeight: FontWeight.w700,
            color: isToday ? Color(0xFF1B75BC) : Color(0xFF6B7280),
            letterSpacing: 0.5,
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          '${date.day}',
          style: TextStyle(
            fontSize: 22.sp,
            fontWeight: FontWeight.w800,
            color: isToday ? Color(0xFF1B75BC) : Color(0xFF0B1B3A),
          ),
        ),
      ],
    );
  }
}

class _WeekendPlaceholder extends StatelessWidget {
  const _WeekendPlaceholder();

  @override
  Widget build(BuildContext context) {
    return DottedBorderBox(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 30.h),
        child: Column(
          children: [
            Icon(Icons.event_busy, size: 26.sp, color: Color(0xFF6B7280)),
            SizedBox(height: 8.h),
            Text(
              'Weekend -',
              style: TextStyle(fontSize: 13.sp, color: Color(0xFF6B7280)),
            ),
            Text(
              'No Sessions',
              style: TextStyle(fontSize: 13.sp, color: Color(0xFF6B7280)),
            ),
          ],
        ),
      ),
    );
  }
}

/// Small helper to fake a dashed border without pulling in an extra
/// package, used for the weekend placeholder box.
class DottedBorderBox extends StatelessWidget {
  final Widget child;

  const DottedBorderBox({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFFF3F4F7).withOpacity(0.4),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Color(0xFFE3E8EF), width: 1.2),
      ),
      child: child,
    );
  }
}
