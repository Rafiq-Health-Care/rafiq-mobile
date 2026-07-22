import 'package:dartz/dartz.dart';
import 'package:rafiq/core/errors/failure.dart';
import 'package:rafiq/features/chat_bot/domain/repository/chat_repository.dart';

class StopVoiceRecordingUseCase {
  final ChatRepository repository;
  const StopVoiceRecordingUseCase(this.repository);

  Future<Either<Failure, String>> call() {
    return repository.stopRecording();
  }
}
