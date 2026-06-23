import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq/core/utils/extensions/get_app_theme.dart';
import 'package:rafiq/core/utils/extensions/size_extension.dart';

class RafiqPrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final IconData? icon;

  const RafiqPrimaryButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.icon = Icons.arrow_forward_rounded,
  });

  @override
  Widget build(BuildContext context) {
    final appTheme = context.appTheme;

    return Container(
      width: context.width,
      height: 56.h,
      decoration: BoxDecoration(
        color: appTheme.cyanColor400,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: const Color(0x3F137FEC),
            blurRadius: 15,
            spreadRadius: -3,
            offset: const Offset(0, 10),
          ),
          BoxShadow(
            color: const Color(0x3F137FEC),
            blurRadius: 6,
            spreadRadius: -4,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 16,
            ), // padding: 16px 0px
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // --- Text ---
                Text(
                  text,
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                    height: 24 / 16,
                    color: Colors.white,
                  ),
                ),

                if (icon != null) ...[
                  SizedBox(width: 8.w),
                  Icon(icon, size: 15.sp, color: Colors.white),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
