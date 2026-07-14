import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq/core/utils/extensions/size_extension.dart';

class ConsultationBookedDialog extends StatelessWidget {
  final VoidCallback onGoToAppointments;

  const ConsultationBookedDialog({super.key, required this.onGoToAppointments});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.symmetric(horizontal: 13.w),
      child: Container(
        width: context.width,
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
        decoration: BoxDecoration(
          color: const Color(0xFFFFFFFF),
          border: Border.all(color: const Color(0xFFA7A7A7), width: 1),
          borderRadius: BorderRadius.circular(24.r),
          boxShadow: [
            BoxShadow(
              color: const Color(0xff000000).withValues(alpha: 0.25),
              blurRadius: 50.r,
              offset: Offset(0, 25.h),
              spreadRadius: -16.r,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            // --- Success Animation & Header Container ---
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 16.h),
                // 1. Green Circular Background & Icon
                Container(
                  width: 106.w,
                  height: 106.h,
                  decoration: const BoxDecoration(
                    color: Color(0xFFDCFCE7),
                    shape: BoxShape.circle,
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.check_circle_rounded,
                      size: 48,
                      color: Color(0xFF22C55E),
                    ),
                  ),
                ),
                SizedBox(height: 16.h),

                // 2. Heading 1 (Title)
                Text(
                  'Consultation Booked\nSuccessfully!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.bold,
                    fontSize: 16.sp,
                    height: 36 / 16,
                    color: const Color(0xFF0A213C),
                  ),
                ),
                SizedBox(height: 8.h),

                // 3. Subtitle Description
                Text(
                  'A confirmation email has been sent to your registered address.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    fontSize: 12.sp,
                    height: 28 / 12,
                    color: const Color(0xFF64748B),
                  ),
                ),
              ],
            ),

            // --- Primary Action Button ---
            SizedBox(
              width: double.infinity,
              height: 56.h,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  onGoToAppointments();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF11325B),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  'Go to My Appointments',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.bold,
                    fontSize: 16.sp,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
