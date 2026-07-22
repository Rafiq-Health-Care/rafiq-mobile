import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rafiq/features/chat_bot/domain/entities/chat_message.dart';
import 'package:rafiq/features/chat_bot/domain/repository/chat_repository.dart';
import 'package:rafiq/features/chat_bot/domain/use_case/cancel_voice_recording_use_case.dart';
import 'package:rafiq/features/chat_bot/domain/use_case/play_audio_message_use_case.dart';
import 'package:rafiq/features/chat_bot/domain/use_case/send_text_message_use_case.dart';
import 'package:rafiq/features/chat_bot/domain/use_case/send_voice_message_use_case.dart';
import 'package:rafiq/features/chat_bot/domain/use_case/start_voice_recording_use_case.dart';
import 'package:rafiq/features/chat_bot/domain/use_case/stop_audio_playback_use_case.dart';
import 'package:rafiq/features/chat_bot/domain/use_case/stop_voice_recording_use_case.dart';

part 'chat_state.dart';

const _defaultErrorMessage =
    "Sorry, I couldn't reach the assistant. Please try again.";

class ChatCubit extends Cubit<ChatState> {
  ChatCubit({
    required this.sendTextMessageUseCase,
    required this.sendVoiceMessageUseCase,
    required this.startVoiceRecordingUseCase,
    required this.stopVoiceRecordingUseCase,
    required this.cancelVoiceRecordingUseCase,
    required this.playAudioMessageUseCase,
    required this.stopAudioPlaybackUseCase,
    required ChatRepository repository,
  }) : _repository = repository,
       super(const ChatState()) {
    _playbackSubscription = _repository.onPlaybackComplete.listen((_) {
      emit(state.copyWith(clearPlayingAudio: true));
    });
  }

  final SendTextMessageUseCase sendTextMessageUseCase;
  final SendVoiceMessageUseCase sendVoiceMessageUseCase;
  final StartVoiceRecordingUseCase startVoiceRecordingUseCase;
  final StopVoiceRecordingUseCase stopVoiceRecordingUseCase;
  final CancelVoiceRecordingUseCase cancelVoiceRecordingUseCase;
  final PlayAudioMessageUseCase playAudioMessageUseCase;
  final StopAudioPlaybackUseCase stopAudioPlaybackUseCase;
  final ChatRepository _repository;

  StreamSubscription<void>? _playbackSubscription;

  Future<void> sendMessage(String text) async {
    final trimmed = text.trim();
    if (trimmed.isEmpty || state.isSending) return;

    final withUserMessage = List<ChatMessage>.from(state.messages)
      ..add(ChatMessage.text(text: trimmed, sender: ChatSender.user));
    emit(state.copyWith(messages: withUserMessage, isSending: true));

    final result = await sendTextMessageUseCase(trimmed);
    result.fold(
      (failure) => _appendBotError(failure.message),
      (reply) {
        final withReply = List<ChatMessage>.from(state.messages)
          ..add(ChatMessage.text(text: reply, sender: ChatSender.bot));
        emit(state.copyWith(messages: withReply, isSending: false));
      },
    );
  }

  /// Called when the mic button is tapped: starts recording.
  Future<void> startRecording() async {
    if (state.isRecording || state.isSending) return;
    final result = await startVoiceRecordingUseCase();
    result.fold(
      (failure) => emit(state.copyWith(errorMessage: failure.message)),
      (_) => emit(state.copyWith(isRecording: true, clearError: true)),
    );
  }

  /// Called when the mic button is released: stops recording and sends it.
  Future<void> stopRecordingAndSend() async {
    if (!state.isRecording) return;

    final stopResult = await stopVoiceRecordingUseCase();
    await stopResult.fold(
      (failure) async {
        emit(state.copyWith(isRecording: false, errorMessage: failure.message));
      },
      (audioPath) async {
        final withUserAudio = List<ChatMessage>.from(state.messages)
          ..add(ChatMessage.audio(audioPath: audioPath, sender: ChatSender.user));
        emit(
          state.copyWith(
            messages: withUserAudio,
            isRecording: false,
            isSending: true,
          ),
        );

        final sendResult = await sendVoiceMessageUseCase(audioPath);
        await sendResult.fold(
          (failure) async => _appendBotError(failure.message),
          (replyAudioPath) async {
            final withReply = List<ChatMessage>.from(state.messages)
              ..add(
                ChatMessage.audio(
                  audioPath: replyAudioPath,
                  sender: ChatSender.bot,
                ),
              );
            emit(state.copyWith(messages: withReply, isSending: false));
            await playOrStopAudio(replyAudioPath);
          },
        );
      },
    );
  }

  /// Cancels an in-progress recording (e.g. user swipes away from the mic).
  Future<void> cancelRecording() async {
    if (!state.isRecording) return;
    await cancelVoiceRecordingUseCase();
    emit(state.copyWith(isRecording: false));
  }

  /// Toggles play/pause for a given audio bubble.
  Future<void> playOrStopAudio(String filePath) async {
    if (state.playingAudioPath == filePath) {
      await stopAudioPlaybackUseCase();
      emit(state.copyWith(clearPlayingAudio: true));
      return;
    }

    final result = await playAudioMessageUseCase(filePath);
    result.fold(
      (failure) => emit(state.copyWith(errorMessage: failure.message)),
      (_) => emit(
        state.copyWith(playingAudioPath: filePath, clearError: true),
      ),
    );
  }

  void _appendBotError(String message) {
    final withError = List<ChatMessage>.from(state.messages)
      ..add(
        ChatMessage.text(
          text: message.isNotEmpty ? message : _defaultErrorMessage,
          sender: ChatSender.bot,
        ),
      );
    emit(state.copyWith(messages: withError, isSending: false));
  }

  @override
  Future<void> close() {
    _playbackSubscription?.cancel();
    return super.close();
  }
}
