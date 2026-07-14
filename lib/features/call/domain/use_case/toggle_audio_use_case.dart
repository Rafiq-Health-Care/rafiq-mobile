import 'package:rafiq/core/errors/failure.dart';
import 'package:rafiq/features/call/domain/repository/call_repo.dart';
import 'package:dartz/dartz.dart';

class ToggleAudioUseCase {
  final CallRepository repository;
  const ToggleAudioUseCase(this.repository);

  Future<Either<Failure, void>> call({required bool isAudioOn}) {
    return repository.toggleAudio(isAudioOn: isAudioOn);
  }
}
