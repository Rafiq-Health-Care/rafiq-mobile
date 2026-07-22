import 'package:dartz/dartz.dart';
import 'package:rafiq/core/errors/failure.dart';
import 'package:rafiq/features/feedback/domain/entities/feedback_entity.dart';
import 'package:rafiq/features/feedback/domain/repositories/feedback_repository.dart';

class GetDoctorFeedbackUseCase {
  final FeedbackRepository repository;

  const GetDoctorFeedbackUseCase(this.repository);

  Future<Either<Failure, List<FeedbackEntity>>> call(String doctorId) {
    return repository.getDoctorFeedback(doctorId);
  }
}
