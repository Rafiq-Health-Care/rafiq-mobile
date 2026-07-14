import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:rafiq/core/di/di.dart';
import 'package:rafiq/features/call/domain/event/agora_call_event.dart';

class RemoteVideo extends StatelessWidget {
  final AgoraCallEvent callEvent;
  final String channelId;
  const RemoteVideo({super.key, required this.callEvent, required this.channelId});

  @override
  Widget build(BuildContext context) {
    if (callEvent is UserJoinedEvent) {
      return AgoraVideoView(
        controller: VideoViewController.remote(
          rtcEngine: getIt<RtcEngine>(),
          canvas: VideoCanvas(uid: (callEvent as UserJoinedEvent).uid),
          connection: RtcConnection(channelId: channelId),
        ),
      );
    } else {
      return const Text(
        'Please wait for remote user to join',
        textAlign: TextAlign.center,
      );
    }
  }
}
