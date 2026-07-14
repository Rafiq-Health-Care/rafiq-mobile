import 'package:rafiq/features/call/domain/event/agora_call_event.dart';

abstract class AgoraDataSource {
  Future<void> initEngine();
  Future<void> startPreview();

  Future<void> joinChannel({
    required String token,
    required String channelId,
    required int uid,
  });
  
  Future<void> leaveChannel();
  Future<void> toggleAudio({required bool isAudioOn});
  Future<void> toggleVideo({required bool isVideoOn});

  Stream<AgoraCallEvent> get callEvents;
}
