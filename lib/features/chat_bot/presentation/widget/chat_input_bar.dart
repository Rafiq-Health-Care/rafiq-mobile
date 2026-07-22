import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq/core/utils/extensions/get_app_theme.dart';

class ChatInputBar extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSend;
  final bool isSending;
  final bool isRecording;
  final VoidCallback onStartRecording;
  final VoidCallback onStopRecordingAndSend;
  final VoidCallback onCancelRecording;

  const ChatInputBar({
    super.key,
    required this.controller,
    required this.onSend,
    required this.onStartRecording,
    required this.onStopRecordingAndSend,
    required this.onCancelRecording,
    this.isSending = false,
    this.isRecording = false,
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
      child: isRecording
          ? _RecordingRow(onCancel: onCancelRecording, onSend: onStopRecordingAndSend)
          : Row(
              children: [
                Icon(
                  Icons.badge_outlined,
                  color: context.appTheme.deepDarkBlueColor,
                  size: 26.sp,
                ),
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
                    style: TextStyle(
                      color: context.appTheme.deepDarkBlueColor,
                      fontSize: 15.sp,
                    ),
                  ),
                ),
                SizedBox(width: 8.w),
                _MicButton(isSending: isSending, onTap: onStartRecording),
                SizedBox(width: 8.w),
                _SendButton(isSending: isSending, onTap: onSend),
              ],
            ),
    );
  }
}

class _RecordingRow extends StatelessWidget {
  final VoidCallback onCancel;
  final VoidCallback onSend;

  const _RecordingRow({required this.onCancel, required this.onSend});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: onCancel,
          icon: Icon(Icons.delete_outline, color: Colors.redAccent, size: 24.sp),
        ),
        SizedBox(width: 4.w),
        Icon(Icons.fiber_manual_record, color: Colors.redAccent, size: 14.sp),
        SizedBox(width: 8.w),
        Expanded(
          child: Text(
            'Recording voice message...',
            style: TextStyle(
              color: context.appTheme.deepDarkBlueColor,
              fontSize: 15.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        InkWell(
          onTap: onSend,
          borderRadius: BorderRadius.circular(12.r),
          child: Container(
            width: 44.w,
            height: 44.w,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: context.appTheme.deepDarkBlueColor,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(Icons.check, color: Colors.white, size: 22.sp),
          ),
        ),
      ],
    );
  }
}

class _MicButton extends StatelessWidget {
  final bool isSending;
  final VoidCallback onTap;

  const _MicButton({required this.isSending, required this.onTap});

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
          color: Color(0xFFF0F3F9),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Icon(
          Icons.mic_none_rounded,
          color: context.appTheme.deepDarkBlueColor,
          size: 22.sp,
        ),
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
