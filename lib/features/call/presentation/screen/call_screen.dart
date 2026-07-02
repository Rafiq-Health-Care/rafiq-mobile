import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rafiq/core/di/di.dart';
import 'package:rafiq/features/call/domain/event/agora_call_event.dart';
import 'package:rafiq/features/call/presentation/controller/call_cubit/call_cubit.dart';
import 'package:rafiq/features/call/presentation/widget/call_control_bar.dart';

class CallScreen extends StatefulWidget {
  const CallScreen({super.key});

  @override
  State<CallScreen> createState() => _CallScreenState();
}

class _CallScreenState extends State<CallScreen> {
  @override
  void initState() {
    super.initState();
    context.read<CallCubit>().joinCall(
      consultationId: '',
      isVideoOn: true,
      isAudioOn: true,
      uid: 0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<CallCubit, CallState>(
        listener: (context, state) {
          if (state is CallFailure) {
            print("CallFailure: ${state.message}");
          }
          if (state is CallEnd) {
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          if (state is CallSuccess) {
            return Stack(
              children: [
                Center(child: _remoteVideo(state)),
                Align(
                  alignment: Alignment.topLeft,
                  child: SizedBox(
                    width: 100,
                    height: 150,
                    child: Center(
                      child: AgoraVideoView(
                        controller: VideoViewController(
                          rtcEngine: getIt<RtcEngine>(),
                          canvas: VideoCanvas(uid: state.callEntity.uid),
                        ),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: CallControlBar(
                    onToggleMic: () async {
                      await context.read<CallCubit>().toggleAudio();
                    },
                    onToggleVideo: () async {
                      await context.read<CallCubit>().toggleVideo();
                    },
                    onEndCall: () async {
                      await context.read<CallCubit>().endCall(
                        consultationId: '',
                      );
                    },
                  ),
                  // ControlButtons(callEntity: state.callEntity),
                ),
              ],
            );
          } else if (state is CallLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is CallFailure) {
            return Center(child: Text(state.message));
          } else {
            return Center(child: Text('Something went wrong'));
          }
        },
      ),
    );
  }

  Widget _remoteVideo(CallSuccess state) {
    final event = state.event;
    if (event is UserJoinedEvent) {
      return AgoraVideoView(
        controller: VideoViewController.remote(
          rtcEngine: getIt<RtcEngine>(),
          canvas: VideoCanvas(uid: event.uid),
          connection: RtcConnection(channelId: state.callEntity.channelName),
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
