import 'package:dartz/dartz.dart';
import 'package:rafiq/core/errors/failure.dart';
import 'package:rafiq/features/call/domain/repository/call_repo.dart';

class JoinCallUseCase {
  final CallRepository repository;
  const JoinCallUseCase(this.repository);

  Future<Either<Failure, String>> call({
    required String consultationId,
    required int uid,
  }) {
    return repository.joinCall(consultationId: consultationId, uid: uid);
  }
}
