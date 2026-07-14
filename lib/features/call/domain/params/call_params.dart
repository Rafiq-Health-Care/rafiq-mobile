import 'package:equatable/equatable.dart';

class CallParams extends Equatable {
  final int uid;
  final String consultationId;
  final bool isVideoOn;
  final bool isAudioOn;

  const CallParams({
    required this.uid,
    required this.consultationId,
    required this.isVideoOn,
    required this.isAudioOn,
  });

  CallParams copyWith({bool? isVideoOn, bool? isAudioOn}) {
    return CallParams(
      uid: uid,
      consultationId: consultationId,
      isVideoOn: isVideoOn ?? this.isVideoOn,
      isAudioOn: isAudioOn ?? this.isAudioOn,
    );
  }

  @override
  List<Object?> get props => [uid, consultationId, isVideoOn, isAudioOn];
}
