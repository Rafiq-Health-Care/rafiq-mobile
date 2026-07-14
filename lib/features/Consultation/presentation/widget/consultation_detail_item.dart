import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rafiq/core/utils/extensions/get_app_theme.dart';

class ConsultationDetailItem extends StatelessWidget {
  final String iconUrl;
  final String label;
  final String value;

  const ConsultationDetailItem({
    super.key,
    required this.iconUrl,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final appTheme = context.appTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 36.w,
            height: 36.h,

            decoration: BoxDecoration(
              color: const Color(0xFF1241A1).withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Center(
              child: SvgPicture.asset(
                iconUrl,
                width: 20.w,
                height: 20.h,
                colorFilter: ColorFilter.mode(
                  appTheme.deepDarkBlueColor,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),

          // --- Text Container ---
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                    color: Color(0xFF64748B),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w700,
                    fontSize: 11,
                    color: Color(0xFF0A213C),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
