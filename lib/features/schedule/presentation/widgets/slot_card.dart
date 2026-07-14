import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:rafiq/features/schedule/domain/entities/slot_entity.dart';
import 'package:rafiq/features/schedule/domain/entities/slot_status.dart';

/// Renders one [SlotEntity] as a card. A single reusable widget drives all
/// six visual variants (available / booked / blocked / completed /
/// cancelled / pending) purely from [slot.status], so no per-status widget
/// duplication is needed.
class SlotCard extends StatelessWidget {
  final SlotEntity slot;
  final VoidCallback? onJoinCall;
  final VoidCallback? onTap;

  const SlotCard({super.key, required this.slot, this.onJoinCall, this.onTap});

  String get _timeRange {
    final fmt = DateFormat('HH:mm');
    return '${fmt.format(slot.startTime)} - ${fmt.format(slot.endTime)}';
  }

  @override
  Widget build(BuildContext context) {
    switch (slot.status) {
      case SlotStatus.blocked:
        return _BlockedCard(timeRange: _timeRange);
      case SlotStatus.available:
        return _AvailableCard(timeRange: _timeRange, onTap: onTap);
      case SlotStatus.booked:
        return _FilledCard(
          slot: slot,
          timeRange: _timeRange,
          color: Color(0xFFEFF1F4),
          badgeLabel: 'BOOKED',
          showJoinButton: true,
          onJoinCall: onJoinCall,
          onTap: onTap,
        );
      case SlotStatus.pending:
        return _FilledCard(
          slot: slot,
          timeRange: _timeRange,
          color: Color(0xFFF2A81D),
          badgeLabel: 'PENDING',
          onTap: onTap,
        );
      case SlotStatus.completed:
        return _TintedCard(
          slot: slot,
          timeRange: _timeRange,
          borderColor: Color(0xFF16A874),
          textColor: Color(0xFF16A874),
          backgroundColor: Color(0xFFE7F7EF),
          onTap: onTap,
        );
      case SlotStatus.cancelled:
        return _TintedCard(
          slot: slot,
          timeRange: _timeRange,
          borderColor: Color(0xFFE23D5B),
          textColor: Color(0xFFE23D5B),
          backgroundColor: Color(0xFFFCE9EC),
          onTap: onTap,
        );
    }
  }
}

/// Shared outer shell so every card variant has identical padding/radius/
/// margin — only the fill changes.
class _CardShell extends StatelessWidget {
  final Widget child;
  final Color? backgroundColor;
  final Border? border;
  final VoidCallback? onTap;

  const _CardShell({
    required this.child,
    this.backgroundColor,
    this.border,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16.r),
          onTap: onTap,
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.all(14.r),
            decoration: BoxDecoration(
              color: backgroundColor ?? Colors.white,
              borderRadius: BorderRadius.circular(16.r),
              border: border,
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}

class _BlockedCard extends StatelessWidget {
  final String timeRange;

  const _BlockedCard({required this.timeRange});

  @override
  Widget build(BuildContext context) {
    return _CardShell(
      backgroundColor: Color(0xFFEFF1F4),
      child: Column(
        children: [
          Icon(Icons.block, color: Color(0xFF4B5563), size: 26.sp),
          SizedBox(height: 8.h),
          Text(
            'BLOCKED',
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w700,
              color: Color(0xFF4B5563),
              letterSpacing: 0.5,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            timeRange,
            style: TextStyle(fontSize: 13.sp, color: Color(0xFF4B5563)),
          ),
        ],
      ),
    );
  }
}

class _AvailableCard extends StatelessWidget {
  final String timeRange;
  final VoidCallback? onTap;

  const _AvailableCard({required this.timeRange, this.onTap});

  @override
  Widget build(BuildContext context) {
    return _CardShell(
      backgroundColor: Color(0xFFE9F9F1),
      onTap: onTap,
      border: Border.all(color: Color(0xFF7FD4AE), width: 1.4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.videocam, size: 16.sp, color: Color(0xFF16A874)),
              SizedBox(width: 6.w),
              Text(
                'AVAILABLE',
                style: TextStyle(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF16A874),
                ),
              ),
            ],
          ),
          SizedBox(height: 6.h),
          Text(
            timeRange,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: Color(0xFF0B1B3A),
            ),
          ),
        ],
      ),
    );
  }
}

class _FilledCard extends StatelessWidget {
  final SlotEntity slot;
  final String timeRange;
  final Color color;
  final String badgeLabel;
  final bool showJoinButton;
  final VoidCallback? onJoinCall;
  final VoidCallback? onTap;

  const _FilledCard({
    required this.slot,
    required this.timeRange,
    required this.color,
    required this.badgeLabel,
    this.showJoinButton = false,
    this.onJoinCall,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return _CardShell(
      backgroundColor: color,
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                slot.patientName != null ? badgeLabel : timeRange,
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                  letterSpacing: 0.5,
                ),
              ),
              Icon(Icons.videocam, size: 16.sp, color: Colors.white),
            ],
          ),
          if (slot.patientName != null) ...[
            SizedBox(height: 6.h),
            Text(
              slot.patientName!,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 2.h),
            Text(
              timeRange,
              style: TextStyle(fontSize: 13.sp, color: Colors.white70),
            ),
          ],
          if (showJoinButton) ...[
            SizedBox(height: 10.h),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: onJoinCall,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: color,
                  padding: EdgeInsets.symmetric(vertical: 10.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  'JOIN CALL',
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _TintedCard extends StatelessWidget {
  final SlotEntity slot;
  final String timeRange;
  final Color borderColor;
  final Color textColor;
  final Color backgroundColor;
  final VoidCallback? onTap;

  const _TintedCard({
    required this.slot,
    required this.timeRange,
    required this.borderColor,
    required this.textColor,
    required this.backgroundColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return _CardShell(
      backgroundColor: backgroundColor,
      onTap: onTap,
      border: Border(left: BorderSide(color: borderColor, width: 4)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            slot.status.label.toUpperCase(),
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w700,
              color: textColor,
              letterSpacing: 0.5,
            ),
          ),
          if (slot.patientName != null) ...[
            SizedBox(height: 4.h),
            Text(
              slot.patientName!,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w700,
                color: Color(0xFF0B1B3A),
              ),
            ),
          ],
          SizedBox(height: 2.h),
          Text(
            timeRange,
            style: TextStyle(fontSize: 13.sp, color: textColor),
          ),
        ],
      ),
    );
  }
}
