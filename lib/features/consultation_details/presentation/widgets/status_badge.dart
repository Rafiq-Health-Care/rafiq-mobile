// status_badge.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq/core/utils/extensions/get_app_theme.dart';
import '../../domain/entities/consultation.dart';

class StatusBadge extends StatelessWidget {
  final Consultation consultation;
  const StatusBadge({super.key, required this.consultation});

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    final isCancelled = consultation.isCancelled;

    final label = !isCancelled
        ? consultation.status.name.toUpperCase()
        : (consultation.cancelByPatient ? 'CANCELLED BY PATIENT' : 'CANCELLED BY CLINIC');

    final accent = isCancelled ? theme.accentRedColor : theme.accentBlueColor;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: accent.withOpacity(0.1),
        border: Border.all(color: accent.withOpacity(0.35)),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Text(
        label,
        textAlign: TextAlign.center,
        style: theme.overlineTextStyle.copyWith(color: accent, letterSpacing: 1.0),
      ),
    );
  }
}