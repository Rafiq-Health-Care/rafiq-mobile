import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq/core/utils/extensions/get_app_theme.dart';
import 'package:rafiq/features/call/domain/params/call_params.dart';
import 'package:rafiq/features/call/presentation/controller/call_cubit/call_cubit.dart';
import 'package:rafiq/features/call/presentation/screen/confirmation_modal.dart';
import 'package:rafiq/features/call/presentation/widget/call_action_button.dart';

class CallControlBar extends StatelessWidget {
  final CallParams callParams;
  const CallControlBar({super.key, required this.callParams});

  @override
  Widget build(BuildContext context) {
    final callCubit = context.read<CallCubit>();
    final appTheme = context.appTheme;

    return SizedBox(
      width: 360.w,
      height: 60.h,
      child: Row(
        spacing: 18.w,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // 1. Microphone Icon
          CallActionButton(
            icon: callParams.isAudioOn ? Icons.mic : Icons.mic_off,
            backgroundColor: appTheme.surfaceColor,
            iconColor: callParams.isAudioOn
                ? appTheme.deepDarkBlueColor
                : appTheme.accentRedColor,
            onPressed: callCubit.toggleAudio,
          ),

          // 2. Video Icon
          CallActionButton(
            icon: callParams.isVideoOn ? Icons.videocam : Icons.videocam_off,
            backgroundColor: appTheme.surfaceColor,
            iconColor: callParams.isVideoOn
                ? appTheme.deepDarkBlueColor
                : appTheme.accentRedColor,
            onPressed: callCubit.toggleVideo,
          ),

          // 3. End Call Icon
          CallActionButton(
            icon: Icons.call_end,
            backgroundColor: const Color(0xFFFF1E1E),
            iconColor: Colors.white,
            onPressed: () {
              showDialog(
                context: context,
                barrierDismissible: true,
                builder: (_) => ConfirmationModal(onConfirm: callCubit.endCall),
              );
            },
          ),
        ],
      ),
    );
  }
}
