import 'package:rafiq/core/errors/failure.dart';
import 'package:rafiq/features/call/domain/repository/call_repo.dart';
import 'package:dartz/dartz.dart';

class ToggleVideoUseCase {
  final CallRepository repository;
  const ToggleVideoUseCase(this.repository);

  Future<Either<Failure, void>> call({required bool isVideoOn}) {
    return repository.toggleVideo(isVideoOn: isVideoOn);
  }
}
