import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq/features/schedule/domain/entities/schedule_stats.dart';

/// Bottom bar: three stat chips + a "Next Session" call-to-action.
/// Uses [Wrap] so chips reflow on narrow screens instead of overflowing.
class StatsBar extends StatelessWidget {
  final ScheduleStats stats;
  final VoidCallback? onJoinNext;

  const StatsBar({super.key, required this.stats, this.onJoinNext});

  String get _nextSessionLabel {
    final next = stats.nextSession;
    if (next == null) return 'None scheduled';
    final diff = next.startTime.difference(DateTime.now());
    if (diff.inMinutes <= 0) return 'Starting now';
    if (diff.inMinutes < 60) return 'In ${diff.inMinutes} mins';
    return 'In ${diff.inHours}h ${diff.inMinutes % 60}m';
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 16.w,
      runSpacing: 16.h,
      children: [
        _StatChip(
          icon: Icons.event_available,
          iconBg: const Color(0xFFE1EEFC),
          iconColor: Color(0xFFEFF1F4),
          label: 'Weekly Slots',
          value: '${stats.weeklySlots}',
        ),
        _StatChip(
          icon: Icons.check_circle,
          iconBg: Color(0xFFE7F7EF),
          iconColor: Color(0xFF16A874),
          label: 'Completed',
          value: '${stats.completed}',
        ),
        _StatChip(
          icon: Icons.pending_actions,
          iconBg: const Color(0xFFE1EEFC),
          iconColor: Color(0xFFEFF1F4),
          label: 'Pending',
          value: '${stats.pending}',
        ),
        _NextSessionChip(label: _nextSessionLabel, onJoin: onJoinNext),
      ],
    );
  }
}

class _StatChip extends StatelessWidget {
  final IconData icon;
  final Color iconBg;
  final Color iconColor;
  final String label;
  final String value;

  const _StatChip({
    required this.icon,
    required this.iconBg,
    required this.iconColor,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 14.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(color: Color(0xFFE3E8EF)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40.r,
            height: 40.r,
            decoration: BoxDecoration(color: iconBg, shape: BoxShape.circle),
            child: Icon(icon, size: 20.sp, color: iconColor),
          ),
          SizedBox(width: 12.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(fontSize: 13.sp, color: Color(0xFF6B7280)),
              ),
              Text(
                value,
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF0B1B3A),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _NextSessionChip extends StatelessWidget {
  final String label;
  final VoidCallback? onJoin;

  const _NextSessionChip({required this.label, this.onJoin});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 14.h),
      decoration: BoxDecoration(
        color: Color(0xFF0B1F4D),
        borderRadius: BorderRadius.circular(24.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40.r,
            height: 40.r,
            decoration: const BoxDecoration(
              color: Colors.white24,
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.videocam, size: 20.sp, color: Colors.white),
          ),
          SizedBox(width: 12.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Next Session',
                style: TextStyle(fontSize: 13.sp, color: Colors.white70),
              ),
              Text(
                label,
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          SizedBox(width: 16.w),
          ElevatedButton(
            onPressed: onJoin,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Color(0xFF0B1F4D),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.r),
              ),
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
              elevation: 0,
            ),
            child: Text(
              'Join',
              style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w700),
            ),
          ),
        ],
      ),
    );
  }
}
