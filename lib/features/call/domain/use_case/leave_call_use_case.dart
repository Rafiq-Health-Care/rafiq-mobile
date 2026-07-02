import 'package:rafiq/core/errors/failure.dart';
import 'package:rafiq/features/call/domain/repository/call_repo.dart';
import 'package:dartz/dartz.dart';

class LeaveCallUseCase {
  final CallRepository repository;
  const LeaveCallUseCase(this.repository);

  Future<Either<Failure, void>> call({required String consultationId}) {
    return repository.leaveCall(consultationId: consultationId);
  }
}
