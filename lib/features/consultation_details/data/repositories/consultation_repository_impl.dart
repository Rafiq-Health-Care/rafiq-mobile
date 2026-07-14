import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:rafiq/core/errors/failure.dart';
import 'package:rafiq/core/errors/server_failure.dart';
import 'package:rafiq/core/errors/unknown_failure.dart';
import 'package:rafiq/features/consultation_details/data/models/consultation_model.dart';
import '../../domain/entities/consultation.dart';
import '../../domain/repositories/consultation_repository.dart';
import '../data_source/consultation_remote_data_source.dart';

class ConsultationDetailsRepositoryImpl implements ConsultationDetailsRepository {
  final ConsultationRemoteDataSource remoteDataSource;
  ConsultationDetailsRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, Consultation>> getConsultationDetails({
    required String slotId,
  }) async {
    final response = await _runGuarded<ConsultationModel>(
      () => remoteDataSource.getConsultationDetails(slotId),
    );

    return response.fold((l) => Left(l), (r) => Right(r.toEntity()));
  }

  @override
  Future<Either<Failure, void>> cancelConsultation({
    required String consultationId,
    String? reason,
  }) {
    return _runGuarded(
      () => remoteDataSource.cancelConsultation(consultationId, reason),
    );
  }

  Future<Either<Failure, T>> _runGuarded<T>(Future<T> Function() action) async {
    try {
      final result = await action();
      return Right(result);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }
}
