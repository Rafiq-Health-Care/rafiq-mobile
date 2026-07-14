import 'dart:async';
import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/foundation.dart';
import 'package:rafiq/core/constants/secure.dart';
import 'package:rafiq/features/call/data/data_source/agora_data_source.dart';
import 'package:rafiq/features/call/domain/event/agora_call_event.dart';

class AgoraDataSourceImpl implements AgoraDataSource {
  final RtcEngine _engine;
  final StreamController<AgoraCallEvent> _eventStreamController =
      StreamController<AgoraCallEvent>.broadcast();

  AgoraDataSourceImpl({required RtcEngine engine}) : _engine = engine;

  @override
  Stream<AgoraCallEvent> get callEvents => _eventStreamController.stream;

  @override
  Future<void> initEngine() async {
    await _engine.initialize(
      const RtcEngineContext(
        appId: agoraAppId,
        channelProfile: ChannelProfileType.channelProfileCommunication,
      ),
    );

    _engine.registerEventHandler(
      RtcEngineEventHandler(
        onJoinChannelSuccess: (_, _) {
          _eventStreamController.add(LocalJoinedEvent());
        },
        onUserJoined: (_, int remoteUid, _) {
          _eventStreamController.add(UserJoinedEvent(remoteUid));
        },
        onUserOffline: (_, int remoteUid, _) {
          _eventStreamController.add(UserLeftEvent(remoteUid));
        },
        onTokenPrivilegeWillExpire: (_, String token) {
          _eventStreamController.add(ConnectionStateChangedEvent(token));
        },
        onError: (err, msg) {
          if (kDebugMode) {
            print('Error in Agora $err => $msg');
          }
        },
      ),
    );
    await _engine.setClientRole(role: ClientRoleType.clientRoleBroadcaster);
  }

  @override
  Future<void> startPreview() async {
    await _engine.enableVideo();
    await _engine.enableAudio();
    await _engine.startPreview();
  }

  @override
  Future<void> joinChannel({
    required String token,
    required String channelId,
    required int uid,
  }) async {
    await _engine.joinChannel(
      token: token,
      channelId: channelId,
      uid: uid,
      options: ChannelMediaOptions(),
    );
  }

  @override
  Future<void> leaveChannel() async {
    await _engine.stopPreview();
    await _engine.leaveChannel();
    await _engine.release();
  }

  @override
  Future<void> toggleAudio({required bool isAudioOn}) async {
    await _engine.muteLocalAudioStream(!isAudioOn);
  }

  @override
  Future<void> toggleVideo({required bool isVideoOn}) async {
    await _engine.muteLocalVideoStream(!isVideoOn);
    isVideoOn ? await _engine.startPreview() : await _engine.stopPreview();
  }
}
