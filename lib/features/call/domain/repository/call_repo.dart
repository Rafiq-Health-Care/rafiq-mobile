import 'package:dartz/dartz.dart';
import 'package:rafiq/core/errors/failure.dart';
import 'package:rafiq/features/call/domain/entity/call_entity.dart';
import 'package:rafiq/features/call/domain/event/agora_call_event.dart';

abstract class CallRepository {
  Future<Either<Failure, CallEntity>> joinCall({
    required String consultationId,
    required int uid,
    required bool isVideoOn,
    required bool isAudioOn,
  });

  Future<Either<Failure, void>> leaveCall({required String consultationId});
  Future<Either<Failure, void>> toggleAudio({required bool isAudioOn});
  Future<Either<Failure, void>> toggleVideo({required bool isVideoOn});
  Stream<AgoraCallEvent> get callEvents;
}
