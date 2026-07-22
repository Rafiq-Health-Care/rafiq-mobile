import 'package:dartz/dartz.dart';
import 'package:rafiq/core/errors/failure.dart';
import 'package:rafiq/features/chat_bot/domain/repository/chat_repository.dart';

class StartVoiceRecordingUseCase {
  final ChatRepository repository;
  const StartVoiceRecordingUseCase(this.repository);

  Future<Either<Failure, void>> call() {
    return repository.startRecording();
  }
}
