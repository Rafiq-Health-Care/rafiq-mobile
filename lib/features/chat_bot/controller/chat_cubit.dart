import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rafiq/features/chat_bot/data/chat_message.dart';
import 'package:rafiq/features/chat_bot/data/chat_service.dart';
import 'package:rafiq/features/chat_bot/controller/chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit({ChatService? chatService})
      : _chatService = chatService ?? ChatService(),
        super(const ChatState());

  final ChatService _chatService;

  Future<void> sendMessage(String text) async {
    final trimmed = text.trim();
    if (trimmed.isEmpty || state.isSending) return;

    final withUserMessage = List<ChatMessage>.from(state.messages)
      ..add(ChatMessage(text: trimmed, sender: ChatSender.user));

    emit(state.copyWith(messages: withUserMessage, isSending: true));

    final result = await _chatService.sendMessage(trimmed);

    result.fold(
      (failure) {
        final withError = List<ChatMessage>.from(state.messages)
          ..add(
            ChatMessage(
              text: failure.message.isNotEmpty
                  ? failure.message
                  : "Sorry, I couldn't reach the assistant. Please try again.",
              sender: ChatSender.bot,
            ),
          );
        emit(state.copyWith(messages: withError, isSending: false));
      },
      (reply) {
        final withReply = List<ChatMessage>.from(state.messages)
          ..add(ChatMessage(text: reply, sender: ChatSender.bot));
        emit(state.copyWith(messages: withReply, isSending: false));
      },
    );
  }
}