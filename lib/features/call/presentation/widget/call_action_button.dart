import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CallActionButton extends StatelessWidget {
  final IconData icon;
  final Color backgroundColor;
  final Color iconColor;
  final VoidCallback onPressed;

  const CallActionButton({
    super.key,
    required this.icon,
    required this.backgroundColor,
    required this.iconColor,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(45.r), // Using .r for responsive radius
      child: Container(
        width: 60.w,  // Matches 60px width
        height: 60.h, // Matches 60px height
        decoration: BoxDecoration(
          color: backgroundColor,
          shape: BoxShape.circle, // Automatically handles the 44.77px border radius to keep it perfectly round
        ),
        child: Center(
          child: Icon(
            icon,
            color: iconColor,
            size: 24.sp, // Responsive icon scaling
          ),
        ),
      ),
    );
  }
}