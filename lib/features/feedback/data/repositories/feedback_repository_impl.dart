import 'package:dartz/dartz.dart';
import 'package:rafiq/core/errors/failure.dart';
import 'package:rafiq/core/errors/unknown_failure.dart';
import 'package:rafiq/features/feedback/data/datasources/feedback_remote_datasource.dart';
import 'package:rafiq/features/feedback/domain/entities/feedback_entity.dart';
import 'package:rafiq/features/feedback/domain/params/add_feedback_params.dart';
import 'package:rafiq/features/feedback/domain/repositories/feedback_repository.dart';

class FeedbackRepositoryImpl implements FeedbackRepository {
  final FeedbackRemoteDataSource remoteDataSource;

  const FeedbackRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, void>> addFeedback(AddFeedbackParams params) async {
    try {
      await remoteDataSource.addFeedback(
        rating: params.rating,
        comment: params.comment,
        consultationId: params.consultationId,
      );
      return const Right(null);
    } catch (e) {
      // ApiService already converts Dio errors into Failure objects.
      if (e is Failure) return Left(e);
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<FeedbackEntity>>> getDoctorFeedback(
    String doctorId,
  ) async {
    try {
      final models = await remoteDataSource.getDoctorFeedback(doctorId);
      return Right(models.map((m) => m.toEntity()).toList());
    } catch (e) {
      if (e is Failure) return Left(e);
      return Left(UnknownFailure(e.toString()));
    }
  }
}
