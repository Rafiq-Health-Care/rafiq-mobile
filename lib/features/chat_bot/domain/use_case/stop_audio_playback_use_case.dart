import 'package:dartz/dartz.dart';
import 'package:rafiq/core/errors/failure.dart';
import 'package:rafiq/features/chat_bot/domain/repository/chat_repository.dart';

class StopAudioPlaybackUseCase {
  final ChatRepository repository;
  const StopAudioPlaybackUseCase(this.repository);

  Future<Either<Failure, void>> call() {
    return repository.stopPlayback();
  }
}
