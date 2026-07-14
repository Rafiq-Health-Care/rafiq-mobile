import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq/core/utils/extensions/size_extension.dart';

class ConfirmationModal extends StatelessWidget {
  final Future<void> Function() onConfirm;
  const ConfirmationModal({super.key, required this.onConfirm});

  @override
  Widget build(BuildContext context) {
    // Backdrop filter handles the background blur spec
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
      child: Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Container(
          constraints: const BoxConstraints(maxWidth: 448),
          decoration: BoxDecoration(
            color: const Color(0xFFFFFFFF),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFFBFC7D1), width: 1),
            boxShadow: const [
              BoxShadow(
                color: Color(0x40000000), // rgba(0, 0, 0, 0.25)
                offset: Offset(0, 25),
                blurRadius: 50,
                spreadRadius: -12,
              ),
            ],
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildHeaderSection(),
                _buildWarningContent(),
                _buildActionButtons(context, onConfirm),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // --- Header Section ---
  Widget _buildHeaderSection() {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Red Warning Icon Overlay
          CircleAvatar(
            radius: 32.r,
            backgroundColor: const Color(0x1ABA1A1A),
            child: Icon(
              Icons.warning_amber_rounded,
              color: Color(0xFFBA1A1A),
              size: 40.sp,
            ),
          ),
          const SizedBox(height: 16),
          // Heading Text
          const Text(
            'End Consultation',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Manrope',
              fontWeight: FontWeight.bold,
              fontSize: 24,
              height: 32 / 24,
              letterSpacing: -0.24,
              color: Color(0xFF181C20),
            ),
          ),
          const SizedBox(height: 12),
          // Time remaining sub-chip
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            decoration: BoxDecoration(
              color: const Color(0x0D005D90), // rgba(0, 93, 144, 0.05)
              borderRadius: BorderRadius.circular(9999),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.access_time, color: Color(0xFF005D90), size: 16.67),
                SizedBox(width: 8),
                Text(
                  'Time remaining: 15 minutes',
                  style: TextStyle(
                    fontFamily: 'Manrope',
                    fontWeight: FontWeight.w600,
                    fontSize: 14, // Adjusted slightly to fit container safely
                    color: Color(0xFF005D90),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // --- Warning Content Section ---
  Widget _buildWarningContent() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: const Color(0xFFBFC7D1).withValues(alpha: 0.3),
            width: 1,
          ),
        ),
        child: const Text(
          'Concluding this medical session now will finalize the current records. You will not be able to resume this live call without initiating a new appointment.',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'Manrope',
            fontWeight: FontWeight.w400,
            fontSize: 14,
            height: 26 / 14, // ~1.86 line height
            color: Color(0xFF404850),
          ),
        ),
      ),
    );
  }

  // --- Action Buttons ---
  Widget _buildActionButtons(
    BuildContext context,
    Future<void> Function() onConfirm,
  ) {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        children: [
          // Primary Action: Yes, End Consultation
          SizedBox(
            width: context.width,
            height: 48,
            child: ElevatedButton.icon(
              onPressed: () async {
                await onConfirm();
                if (context.mounted) {
                  Navigator.of(context).pop(true);
                }
              },
              icon: const Icon(Icons.logout, color: Colors.white, size: 18),
              label: const Text(
                'Yes, End Consultation',
                style: TextStyle(
                  fontFamily: 'Manrope',
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFBA1A1A),
                elevation: 1,
                shadowColor: const Color(0x0D000000), // rgba(0, 0, 0, 0.05)
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
          const SizedBox(height: 12), // Button Margin layout
          // Secondary Action: Cancel/Keep Session
          SizedBox(
            width: double.infinity,
            height: 48,
            child: OutlinedButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              style: OutlinedButton.styleFrom(
                backgroundColor: const Color(0xFFF7F9FF),
                side: const BorderSide(color: Color(0xFFBFC7D1)),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'Keep Consultation',
                style: TextStyle(
                  fontFamily: 'Manrope',
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: Color(0xFF404850),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
