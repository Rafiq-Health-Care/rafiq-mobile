import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:rafiq/core/utils/extensions/get_app_theme.dart';
import 'package:rafiq/core/utils/extensions/size_extension.dart';
import 'package:rafiq/core/widgets/custom_elevated_button.dart';
import 'package:rafiq/core/widgets/custom_labeled_text_field.dart';
import 'package:rafiq/core/widgets/custom_outlined_button.dart';

class CancelConsultationDialog extends StatefulWidget {
  final String doctorName;
  final DateTime consultationDate;
  final VoidCallback onCancel;

  const CancelConsultationDialog({
    super.key,
    required this.doctorName,
    required this.consultationDate,
    required this.onCancel,
  });

  @override
  State<CancelConsultationDialog> createState() =>
      _CancelConsultationDialogState();
}

class _CancelConsultationDialogState extends State<CancelConsultationDialog> {
  final TextEditingController _reasonController = TextEditingController();

  @override
  void dispose() {
    _reasonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.symmetric(horizontal: 10.w),
      child: Container(
        width: context.width,
        decoration: BoxDecoration(
          color: const Color(0xFFFFFFFF),
          borderRadius: BorderRadius.circular(24.r),
          boxShadow: [
            BoxShadow(
              color: const Color(0xff000000).withValues(alpha: 0.25),
              blurRadius: 50.r,
              offset: Offset(0, 25.h),
              spreadRadius: -12.r,
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- Modal Header ---
            _buildHeader(context),

            // --- Modal Body (Scrollable safe) ---
            Flexible(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(24.r),
                child: Column(
                  spacing: 24.h,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 1. Appointment Summary Card
                    _buildAppointmentSummary(context),

                    // 2. Refund Info Alert
                    _buildRefundAlert(),

                    // 3. Reason Textarea
                    _buildReasonTextField(),
                  ],
                ),
              ),
            ),

            // --- Modal Footer / Actions ---
            _buildFooter(context),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0xFFF1F5F9), width: 1)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Cancel Consultation',
            style: TextStyle(
              fontFamily: 'Inter',
              fontWeight: FontWeight.bold,
              fontSize: 20.sp,
              color: const Color(0xFFF04040),
            ),
          ),
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.close, size: 18),
            color: const Color(0xFF94A3B8),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
        ],
      ),
    );
  }

  Widget _buildAppointmentSummary(BuildContext context) {
    return Container(
      width: context.width,
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: const Color(0xff144BB8).withValues(alpha: 0.05),
        border: Border.all(
          color: const Color(0xff144BB8).withValues(alpha: 0.1),
        ),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'CONSULTATION WITH',
            style: TextStyle(
              fontFamily: 'Inter',
              fontWeight: FontWeight.w600,
              fontSize: 12.sp,
              letterSpacing: 0.6,
              color: const Color(0xFF11325B),
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            widget.doctorName,
            style: TextStyle(
              fontFamily: 'Inter',
              fontWeight: FontWeight.bold,
              fontSize: 16.sp,
              color: const Color(0xFF0A213C),
            ),
          ),
          SizedBox(height: 4.h),
          Row(
            children: [
              const Icon(
                Icons.calendar_today_outlined,
                size: 14,
                color: Color(0xFF475569),
              ),
              SizedBox(width: 4.w),
              Text(
                DateFormat('EEEE, MMMM d').format(widget.consultationDate),
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 14.sp,
                  color: const Color(0xFF475569),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 6.w),
                child: Text(
                  '•',
                  style: TextStyle(
                    color: const Color(0xFF475569),
                    fontSize: 14.sp,
                  ),
                ),
              ),
              const Icon(Icons.access_time, size: 14, color: Color(0xFF475569)),
              SizedBox(width: 4.w),
              Text(
                DateFormat('hh:mm a').format(widget.consultationDate),
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 14.sp,
                  color: const Color(0xFF475569),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRefundAlert() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: const Color(0xFFECFDF5),
        border: Border.all(color: const Color(0xFFD1FAE5)),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 2.h),
            child: const Icon(
              Icons.info_outline,
              color: Color(0xFF059669),
              size: 20,
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Refund Policy',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w600,
                    fontSize: 16.sp,
                    color: const Color(0xFF065F46),
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  'You will receive a full refund to your original payment method within 3-5 business days.',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 12.sp,
                    height: 1.5,
                    color: const Color(0xFF047857),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReasonTextField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 8.h,
      children: [
        CustomLabeledTextField(
          label: 'Reason for cancellation (optional)',
          labelTextStyle: TextStyle(
            fontFamily: 'Inter',
            fontWeight: FontWeight.w600,
            fontSize: 14.sp,
            color: const Color(0xFF334155),
          ),
          controller: _reasonController,
          height: 120.h,
          hint: 'Please tell us why you are canceling...',
          fillColor: const Color(0xFFF8FAFC),
        ),
      ],
    );
  }

  Widget _buildFooter(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
      decoration: const BoxDecoration(
        color: Color(0xFFF8FAFC),
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(24)),
      ),
      child: Row(
        spacing: 12.w,
        children: [
          Expanded(
            child: CustomOutlinedButton(
              onPressed: () => Navigator.pop(context),
              borderSideColor: const Color(0xFFCBD5E1),
              borderRadius: 16.r,
              foregroundColor: context.appTheme.surfaceColor,
              child: Text(
                'Keep',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w600,
                  fontSize: 16.sp,
                  color: const Color(0xFF475569),
                ),
              ),
            ),
          ),
          Expanded(
            child: CustomElevatedButton(
              onPressed: () {
                widget.onCancel();
                Navigator.pop(context);
              },
              backgroundColor: context.appTheme.deepDarkBlueColor,
              foregroundColor: context.appTheme.surfaceColor,
              child: Text(
                'Cancel',
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
    );
  }
}
