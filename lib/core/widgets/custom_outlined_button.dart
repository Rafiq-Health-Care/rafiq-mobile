import 'package:flutter/material.dart';

class CustomOutlinedButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Color? foregroundColor;
  final Color borderSideColor;
  final Widget child;
  final double? borderRadius;

  const CustomOutlinedButton({
    super.key,
    required this.onPressed,
     this.foregroundColor,
    required this.borderSideColor,
    required this.child,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        foregroundColor: foregroundColor,
        side: BorderSide(color: borderSideColor),
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 12),
        ),
      ),
      child: child,
    );
  }
}
