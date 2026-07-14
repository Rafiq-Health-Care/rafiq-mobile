import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq/core/utils/extensions/get_app_theme.dart';

class ChatInputBar extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSend;
  final bool isSending;

  const ChatInputBar({
    super.key,
    required this.controller,
    required this.onSend,
    this.isSending = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Color(0xFFE1E6EF), width: 1.w),
      ),
      child: Row(
        children: [
          Icon(Icons.badge_outlined, color: context.appTheme.deepDarkBlueColor, size: 26.sp),
          SizedBox(width: 12.w),
          Expanded(
            child: TextField(
              controller: controller,
              textInputAction: TextInputAction.send,
              onSubmitted: (_) => onSend(),
              decoration: InputDecoration(
                hintText: 'Enter clinical inquiry...',
                hintStyle: TextStyle(
                  color: Color(0xFF9AA6B7),
                  fontSize: 15.sp,
                ),
                border: InputBorder.none,
              ),
              style: TextStyle(color: context.appTheme.deepDarkBlueColor, fontSize: 15.sp),
            ),
          ),
          SizedBox(width: 8.w),
          _SendButton(isSending: isSending, onTap: onSend),
        ],
      ),
    );
  }
}

class _SendButton extends StatelessWidget {
  final bool isSending;
  final VoidCallback onTap;

  const _SendButton({required this.isSending, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isSending ? null : onTap,
      borderRadius: BorderRadius.circular(12.r),
      child: Container(
        width: 44.w,
        height: 44.w,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: context.appTheme.deepDarkBlueColor,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: isSending
            ? SizedBox(
                width: 18.w,
                height: 18.w,
                child: const CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation(Colors.white),
                ),
              )
            : Icon(Icons.send_rounded, color: Colors.white, size: 20.sp),
      ),
    );
  }
}
