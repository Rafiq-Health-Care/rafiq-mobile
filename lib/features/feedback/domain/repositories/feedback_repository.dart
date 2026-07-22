import 'package:dartz/dartz.dart';
import 'package:rafiq/core/errors/failure.dart';
import 'package:rafiq/features/feedback/domain/entities/feedback_entity.dart';
import 'package:rafiq/features/feedback/domain/params/add_feedback_params.dart';

abstract class FeedbackRepository {
  /// Patient submits feedback for a finished consultation.
  Future<Either<Failure, void>> addFeedback(AddFeedbackParams params);

  /// All feedback left for a given doctor — shown on their profile.
  Future<Either<Failure, List<FeedbackEntity>>> getDoctorFeedback(
    String doctorId,
  );
}
