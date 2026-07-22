import 'package:equatable/equatable.dart';

enum ChatSender { user, bot }

enum ChatMessageType { text, audio }

/// A single message inside the chat conversation.
///
/// A message is either [ChatMessageType.text] (in which case [text] is set)
/// or [ChatMessageType.audio] (in which case [audioPath] points to a local
/// file — either the recording the user made, or the voice reply saved
/// from the server response).
class ChatMessage extends Equatable {
  final String? text;
  final String? audioPath;
  final ChatMessageType type;
  final ChatSender sender;

  const ChatMessage.text({required String this.text, required this.sender})
    : type = ChatMessageType.text,
      audioPath = null;

  const ChatMessage.audio({
    required String this.audioPath,
    required this.sender,
  }) : type = ChatMessageType.audio,
       text = null;

  @override
  List<Object?> get props => [text, audioPath, type, sender];
}
