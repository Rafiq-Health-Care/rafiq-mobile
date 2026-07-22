import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomElevatedButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Color backgroundColor;
  final Color foregroundColor;
  final Widget child;
  final EdgeInsetsGeometry? padding;

  const CustomElevatedButton({
    super.key,
    required this.onPressed,
    required this.backgroundColor,
    required this.foregroundColor,
    required this.child,
    this.padding
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
        padding: padding ?? const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      ),
      child: child,
    );
  }
}
