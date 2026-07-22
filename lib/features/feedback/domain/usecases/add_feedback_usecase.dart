import 'package:dartz/dartz.dart';
import 'package:rafiq/core/errors/failure.dart';
import 'package:rafiq/features/feedback/domain/params/add_feedback_params.dart';
import 'package:rafiq/features/feedback/domain/repositories/feedback_repository.dart';

class AddFeedbackUseCase {
  final FeedbackRepository repository;

  const AddFeedbackUseCase(this.repository);

  Future<Either<Failure, void>> call(AddFeedbackParams params) {
    return repository.addFeedback(params);
  }
}
