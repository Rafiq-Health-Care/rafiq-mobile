/// The chatbot lives behind its own FastAPI service (separate from the main
/// Rafiq backend in `core/networking/api_constants.dart`), so it gets its
/// own small set of constants instead of sharing [ApiConstants].
class ChatApiConstants {
  ChatApiConstants._();

  static const String baseUrl = 'http://192.168.0.104:8000';

  static const String textChat = '/chat/text';
  static const String voiceChat = '/chat/voice';
}
