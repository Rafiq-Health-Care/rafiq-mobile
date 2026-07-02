import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rafiq/features/call/domain/entity/call_entity.dart';
import 'package:rafiq/features/call/domain/event/agora_call_event.dart';
import 'package:rafiq/features/call/domain/use_case/call_events_use_case.dart';
import 'package:rafiq/features/call/domain/use_case/join_call_use_case.dart';
import 'package:rafiq/features/call/domain/use_case/leave_call_use_case.dart';
import 'package:rafiq/features/call/domain/use_case/toggle_audio_use_case.dart';
import 'package:rafiq/features/call/domain/use_case/toggle_video_use_case.dart';
part 'call_state.dart';

class CallCubit extends Cubit<CallState> {
  final JoinCallUseCase joinCallUseCase;
  final LeaveCallUseCase leaveCallUseCase;
  final ToggleAudioUseCase toggleAudioUseCase;
  final ToggleVideoUseCase toggleVideoUseCase;
  final CallEventsUseCase callEventsUseCase;
  StreamSubscription<AgoraCallEvent>? _eventSubscription;
  CallCubit({
    required this.joinCallUseCase,
    required this.leaveCallUseCase,
    required this.toggleAudioUseCase,
    required this.toggleVideoUseCase,
    required this.callEventsUseCase,
  }) : super(CallInitial());

  Future<void> joinCall({
    required String consultationId,
    required bool isVideoOn,
    required bool isAudioOn,
    required int uid,
  }) async {
    emit(CallLoading());
    final permission = await [
      Permission.microphone,
      Permission.camera,
    ].request();

    final bool isDenied =
        permission[Permission.microphone]!.isDenied ||
        permission[Permission.camera]!.isDenied;

    if (isDenied) {
      emit(
        CallFailure(message: "Please allow microphone and camera permissions"),
      );
      return;
    }

    final result = await joinCallUseCase.call(
      consultationId: consultationId,
      isVideoOn: isVideoOn,
      isAudioOn: isAudioOn,
      uid: uid,
    );
    result.fold((failure) => emit(CallFailure(message: failure.message)), (
      callEntity,
    ) {
      emit(CallSuccess(event: LocalJoinedEvent(), callEntity: callEntity));
      _listenToCallEvents();
    });
  }

  void _listenToCallEvents() {
    _eventSubscription?.cancel();
    _eventSubscription = callEventsUseCase.callEvents.listen((event) {
      final currentState = state;
      if (currentState is CallSuccess) {
        emit(currentState.copyWith(event: event));
      }
    });
  }

  Future<void> toggleAudio() async {
    final currentState = state;
    if (currentState is! CallSuccess) return;
    final result = await toggleAudioUseCase.call(
      isAudioOn: !currentState.callEntity.isAudioOn,
    );
    result.fold(
      (failure) {
        emit(CallFailure(message: failure.message));
      },
      (_) {
        emit(
          currentState.copyWith(
            callEntity: currentState.callEntity.copyWith(
              isAudioOn: !currentState.callEntity.isAudioOn,
            ),
          ),
        );
      },
    );
  }

  Future<void> toggleVideo() async {
    final currentState = state;
    if (currentState is! CallSuccess) return;
    final result = await toggleVideoUseCase.call(
      isVideoOn: !currentState.callEntity.isVideoOn,
    );
    result.fold(
      (failure) {
        emit(CallFailure(message: failure.message));
      },
      (_) {
        emit(
          currentState.copyWith(
            callEntity: currentState.callEntity.copyWith(
              isVideoOn: !currentState.callEntity.isVideoOn,
            ),
          ),
        );
      },
    );
  }

  Future<void> endCall({required String consultationId}) async {
    final currentState = state;
    if (currentState is! CallSuccess) return;
    final result = await leaveCallUseCase.call(
      consultationId: currentState.callEntity.channelName,
    );
    result.fold(
      (failure) => emit(CallFailure(message: failure.message)),
      (_) => emit(CallEnd()),
    );
  }

  @override
  Future<void> close() {
    _eventSubscription?.cancel();
    return super.close();
  }
}
