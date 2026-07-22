import 'package:dartz/dartz.dart';
import 'package:rafiq/core/errors/failure.dart';
import 'package:rafiq/features/chat_bot/domain/repository/chat_repository.dart';

class SendVoiceMessageUseCase {
  final ChatRepository repository;
  const SendVoiceMessageUseCase(this.repository);

  Future<Either<Failure, String>> call(String audioFilePath) {
    return repository.sendVoiceMessage(audioFilePath);
  }
}
