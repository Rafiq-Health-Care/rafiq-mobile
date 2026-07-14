import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq/core/router/router_strings.dart';
import 'package:rafiq/core/utils/extensions/navigation_extension.dart';

/// "Consultation is ready" screen — shown once the video room technical
/// checks pass and the user can join their scheduled consultation.
class ConsultationReadyScreen extends StatelessWidget {
  final String consultationId;
  const ConsultationReadyScreen({super.key, required this.consultationId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 40.h),
              _Title(),
              SizedBox(height: 48.h),
              _VideoLinkSection(),
              SizedBox(height: 32.h),
              const TechnicalCheckCard(
                title: 'Technical Check',
                checks: [
                  TechnicalCheckData(label: 'Camera access granted'),
                  TechnicalCheckData(label: 'Microphone access granted'),
                  TechnicalCheckData(label: 'Internet speed stable'),
                ],
              ),
              SizedBox(height: 60.h),
              PrimaryActionButton(
                label: 'Join Now',
                icon: Icons.play_circle_outline,
                textColor: AppColors.teal,
                onPressed: () {
                  context.navigateAndReplace(RouterStrings.callPreviewScreen ,
                  arguments: consultationId
                  );
                },
              ),
              SizedBox(height: 16.h),
              PrimaryActionButton(
                label: 'back',
                textColor: AppColors.danger,
                onPressed: () => Navigator.of(context).maybePop(),
              ),
              SizedBox(height: 24.h),
            ],
          ),
        ),
      ),
    );
  }
}

/// Screen title: "Consultation is ready".
class _Title extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text(
      'Consultation is ready',
      textAlign: TextAlign.left,
      style: TextStyle(
        color: AppColors.navy,
        fontSize: 30.sp,
        fontWeight: FontWeight.w800,
        height: 1.2,
      ),
    );
  }
}

/// Section containing the "Video Consultation Link" heading, its subtitle,
/// and the bordered availability banner.
class _VideoLinkSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Video Consultation Link',
          style: TextStyle(
            color: AppColors.navy,
            fontSize: 22.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 10.h),
        Text(
          'Please join the room 5 minutes before the scheduled time.',
          style: TextStyle(
            color: AppColors.subtitleGrey,
            fontSize: 15.sp,
            height: 1.4,
          ),
        ),
        SizedBox(height: 20.h),
        const AvailabilityBanner(
          message:
              'Link will be available 15 minutes before the session (10:15 AM)',
        ),
      ],
    );
  }
}

/// White pill-shaped button with an optional leading icon.
/// Used for the primary "Join Now" call to action, but generic enough
/// to reuse for any similarly-styled action.
class PrimaryActionButton extends StatelessWidget {
  final String label;
  final IconData? icon;
  final Color textColor;
  final VoidCallback onPressed;

  const PrimaryActionButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.textColor = AppColors.teal,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 60.h,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.cardWhite,
          elevation: 2,
          shadowColor: Colors.black.withOpacity(0.08),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[
              Icon(icon, color: textColor, size: 22.sp),
              SizedBox(width: 10.w),
            ],
            Text(
              label,
              style: TextStyle(
                color: textColor,
                fontSize: 20.sp,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// A single row inside the technical check list, e.g. "Camera access granted".
/// Kept small and reusable so the list can be data-driven.
class TechnicalCheckItem extends StatelessWidget {
  final String label;
  final bool isPassed;

  const TechnicalCheckItem({
    super.key,
    required this.label,
    this.isPassed = true,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: Row(
        children: [
          Icon(
            isPassed ? Icons.check_circle_outline : Icons.error_outline,
            color: isPassed ? AppColors.success : AppColors.danger,
            size: 22.sp,
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                color: AppColors.subtitleGrey,
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Simple data model for a single technical check entry.
class TechnicalCheckData {
  final String label;
  final bool isPassed;

  const TechnicalCheckData({required this.label, this.isPassed = true});
}

/// White rounded card that lists a title and a set of [TechnicalCheckItem]s.
/// Data-driven so new checks can be added without touching the widget.
class TechnicalCheckCard extends StatelessWidget {
  final String title;
  final List<TechnicalCheckData> checks;

  const TechnicalCheckCard({
    super.key,
    required this.title,
    required this.checks,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 22.h),
      decoration: BoxDecoration(
        color: AppColors.cardWhite,
        borderRadius: BorderRadius.circular(18.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 12.r,
            offset: Offset(0, 4.h),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: AppColors.navy,
              fontSize: 19.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 6.h),
          for (final check in checks)
            TechnicalCheckItem(label: check.label, isPassed: check.isPassed),
        ],
      ),
    );
  }
}

/// A bordered info banner used to display availability / timing info.
/// Reusable anywhere a bordered navy-outline message box is needed.
class AvailabilityBanner extends StatelessWidget {
  final String message;

  const AvailabilityBanner({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 18.h),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.borderNavy, width: 1.5.w),
        borderRadius: BorderRadius.circular(14.r),
      ),
      child: Text(
        message,
        style: TextStyle(
          color: AppColors.navy,
          fontSize: 15.sp,
          fontWeight: FontWeight.w600,
          height: 1.4,
        ),
      ),
    );
  }
}

/// Centralized color palette for the Consultation Ready screen.
/// Keeping colors here makes it trivial to re-theme the whole screen.
class AppColors {
  AppColors._();

  static const Color background = Color(0xFFDDE7F8);
  static const Color navy = Color(0xFF16305C);
  static const Color subtitleGrey = Color(0xFF6B7A94);
  static const Color cardWhite = Color(0xFFFFFFFF);
  static const Color teal = Color(0xFF0FA3A3);
  static const Color success = Color(0xFF2FAE60);
  static const Color danger = Color(0xFFE53935);
  static const Color borderNavy = Color(0xFF16305C);
}
