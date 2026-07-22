import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq/core/utils/extensions/get_app_theme.dart';
import 'package:rafiq/features/chat_bot/domain/entities/chat_message.dart';
import 'package:rafiq/features/chat_bot/presentation/controller/chat_cubit/chat_cubit.dart';

class VoiceMessageBubble extends StatelessWidget {
  final ChatMessage message;

  const VoiceMessageBubble({super.key, required this.message});

  bool get _isUser => message.sender == ChatSender.user;

  @override
  Widget build(BuildContext context) {
    final bubbleColor = _isUser
        ? context.appTheme.deepDarkBlueColor
        : const Color(0xFFD9E7FB);
    final contentColor = _isUser ? Colors.white : context.appTheme.deepDarkBlueColor;

    return BlocBuilder<ChatCubit, ChatState>(
      buildWhen: (previous, current) =>
          previous.playingAudioPath != current.playingAudioPath,
      builder: (context, state) {
        final isPlaying = state.playingAudioPath == message.audioPath;
        return Align(
          alignment: _isUser ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            constraints: BoxConstraints(maxWidth: 0.7.sw),
            margin: EdgeInsets.symmetric(vertical: 6.h),
            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
            decoration: BoxDecoration(
              color: bubbleColor,
              borderRadius: BorderRadius.circular(18.r),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                InkWell(
                  borderRadius: BorderRadius.circular(20.r),
                  onTap: () => context.read<ChatCubit>().playOrStopAudio(
                    message.audioPath!,
                  ),
                  child: Icon(
                    isPlaying
                        ? Icons.stop_circle_rounded
                        : Icons.play_circle_fill_rounded,
                    color: contentColor,
                    size: 34.sp,
                  ),
                ),
                SizedBox(width: 10.w),
                _VoiceWaveform(color: contentColor, animate: isPlaying),
                SizedBox(width: 10.w),
                Icon(Icons.graphic_eq, color: contentColor, size: 18.sp),
              ],
            ),
          ),
        );
      },
    );
  }
}

/// A minimal static "waveform" look — a row of bars — used to give the
/// voice bubble some visual weight without needing real amplitude data.
class _VoiceWaveform extends StatelessWidget {
  final Color color;
  final bool animate;

  const _VoiceWaveform({required this.color, required this.animate});

  @override
  Widget build(BuildContext context) {
    final heights = [10.0, 18.0, 8.0, 22.0, 14.0, 20.0, 9.0];
    return SizedBox(
      width: 70.w,
      height: 24.h,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          for (final h in heights)
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: 3.w,
              height: (animate ? h : h * 0.6).h,
              decoration: BoxDecoration(
                color: color.withOpacity(animate ? 1 : 0.6),
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
        ],
      ),
    );
  }
}
