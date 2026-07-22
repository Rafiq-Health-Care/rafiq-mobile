import 'package:dartz/dartz.dart';
import 'package:rafiq/core/errors/failure.dart';
import 'package:rafiq/features/chat_bot/domain/repository/chat_repository.dart';

class PlayAudioMessageUseCase {
  final ChatRepository repository;
  const PlayAudioMessageUseCase(this.repository);

  Future<Either<Failure, void>> call(String filePath) {
    return repository.playAudio(filePath);
  }
}
