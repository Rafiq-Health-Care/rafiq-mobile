import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rafiq/features/call/domain/entity/call_entity.dart';
import 'package:rafiq/features/call/presentation/controller/call_cubit/call_cubit.dart';

class ControlButtons extends StatelessWidget {
  final CallEntity callEntity;
  const ControlButtons({super.key, required this.callEntity});

  @override
  Widget build(BuildContext context) {
    final callCubit = context.read<CallCubit>();
    return Row(
      children: [
        IconButton(
          onPressed: () async => await callCubit.toggleAudio(),
          icon: Icon(callEntity.isAudioOn ? Icons.mic : Icons.mic_off),
        ),
        IconButton(
          onPressed: () async => await callCubit.toggleVideo(),
          icon: Icon(
            callEntity.isVideoOn ? Icons.videocam : Icons.videocam_off,
          ),
        ),
        IconButton(
          onPressed: () async => await callCubit.endCall(consultationId: ''),
          icon: Icon(Icons.call_end),
        ),
      ],
    );
  }
}
