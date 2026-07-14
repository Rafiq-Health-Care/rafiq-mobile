import 'package:dartz/dartz.dart';
import 'package:rafiq/core/errors/failure.dart';
import 'package:rafiq/features/call/domain/event/agora_call_event.dart';

abstract class CallRepository {
  Future<Either<Failure, void>> startPreview();
  Future<Either<Failure, String>> joinCall({
    required String consultationId,
    required int uid,
  });

  Future<Either<Failure, void>> leaveCall({required String consultationId});
  Future<Either<Failure, void>> toggleAudio({required bool isAudioOn});
  Future<Either<Failure, void>> toggleVideo({required bool isVideoOn});
  Stream<AgoraCallEvent> get callEvents;
}
