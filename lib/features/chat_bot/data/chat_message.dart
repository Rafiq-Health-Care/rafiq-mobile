enum ChatSender { user, bot }

class ChatMessage {
  final String text;
  final ChatSender sender;

  const ChatMessage({required this.text, required this.sender});
}
