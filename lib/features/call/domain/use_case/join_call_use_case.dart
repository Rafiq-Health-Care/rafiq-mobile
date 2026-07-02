import 'package:dartz/dartz.dart';
import 'package:rafiq/core/errors/failure.dart';
import 'package:rafiq/features/call/domain/entity/call_entity.dart';
import 'package:rafiq/features/call/domain/repository/call_repo.dart';

class JoinCallUseCase {
  final CallRepository repository;
  const JoinCallUseCase(this.repository);

  Future<Either<Failure, CallEntity>> call({
    required String consultationId,
    required bool isVideoOn,
    required bool isAudioOn,
    required int uid,
  }) {
    return repository.joinCall(
      consultationId: consultationId,
      isVideoOn: isVideoOn,
      isAudioOn: isAudioOn,
      uid: uid,
    );
  }
}
