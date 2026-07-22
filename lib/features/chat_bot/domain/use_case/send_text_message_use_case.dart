import 'package:dartz/dartz.dart';
import 'package:rafiq/core/errors/failure.dart';
import 'package:rafiq/features/chat_bot/domain/repository/chat_repository.dart';

class SendTextMessageUseCase {
  final ChatRepository repository;
  const SendTextMessageUseCase(this.repository);

  Future<Either<Failure, String>> call(String text) {
    return repository.sendTextMessage(text);
  }
}
