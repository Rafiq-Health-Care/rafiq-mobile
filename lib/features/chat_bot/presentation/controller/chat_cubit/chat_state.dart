part of 'chat_cubit.dart';

class ChatState extends Equatable {
  const ChatState({
    this.messages = const [],
    this.isSending = false,
    this.isRecording = false,
    this.playingAudioPath,
    this.errorMessage,
  });

  final List<ChatMessage> messages;

  /// True while waiting for a text or voice reply from the assistant.
  final bool isSending;

  /// True while the microphone is actively capturing a voice message.
  final bool isRecording;

  /// The file path of the audio bubble currently playing, if any.
  final String? playingAudioPath;

  /// A transient failure message to surface once (e.g. via a snack bar).
  final String? errorMessage;

  ChatState copyWith({
    List<ChatMessage>? messages,
    bool? isSending,
    bool? isRecording,
    String? playingAudioPath,
    bool clearPlayingAudio = false,
    String? errorMessage,
    bool clearError = false,
  }) {
    return ChatState(
      messages: messages ?? this.messages,
      isSending: isSending ?? this.isSending,
      isRecording: isRecording ?? this.isRecording,
      playingAudioPath: clearPlayingAudio
          ? null
          : (playingAudioPath ?? this.playingAudioPath),
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }

  @override
  List<Object?> get props => [
    messages,
    isSending,
    isRecording,
    playingAudioPath,
    errorMessage,
  ];
}
