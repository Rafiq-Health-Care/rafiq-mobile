import 'package:equatable/equatable.dart';

class CallEntity extends Equatable {
  final String channelName;
  final String token;
  final int uid;
  final bool isVideoOn;
  final bool isAudioOn;

  const CallEntity({
    required this.channelName,
    required this.token,
    required this.uid,
    required this.isVideoOn,
    required this.isAudioOn,
  });

  CallEntity copyWith({
    String? channelName,
    String? token,
    int? uid,
    bool? isVideoOn,
    bool? isAudioOn,
  }) {
    return CallEntity(
      channelName: channelName ?? this.channelName,
      token: token ?? this.token,
      uid: uid ?? this.uid,
      isVideoOn: isVideoOn ?? this.isVideoOn,
      isAudioOn: isAudioOn ?? this.isAudioOn,
    );
  }

  @override
  List<Object?> get props => [channelName, token, uid, isVideoOn, isAudioOn];
}
