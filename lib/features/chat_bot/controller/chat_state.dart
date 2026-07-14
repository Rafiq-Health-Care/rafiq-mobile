import 'package:rafiq/features/chat_bot/data/chat_message.dart';

class ChatState {
  const ChatState({
    this.messages = const [],
    this.isSending = false,
  });

  final List<ChatMessage> messages;
  final bool isSending;

  ChatState copyWith({
    List<ChatMessage>? messages,
    bool? isSending,
  }) {
    return ChatState(
      messages: messages ?? this.messages,
      isSending: isSending ?? this.isSending,
    );
  }
}