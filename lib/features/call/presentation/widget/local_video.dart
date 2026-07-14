import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq/core/di/di.dart';
import 'package:rafiq/features/call/domain/params/call_params.dart';

class LocalVideo extends StatelessWidget {
  final CallParams callParams;
  const LocalVideo({super.key, required this.callParams});

  @override
  Widget build(BuildContext context) {
    if (callParams.isVideoOn) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(15.r),
        child: Container(
          height: 140.h,
          width: 100.w,
          color: Colors.grey[900],
          child: AgoraVideoView(
            controller: VideoViewController(
              rtcEngine: getIt<RtcEngine>(),
              canvas: VideoCanvas(uid: callParams.uid),
            ),
          ),
        ),
      );
    }
    return SizedBox.shrink();
  }
}
