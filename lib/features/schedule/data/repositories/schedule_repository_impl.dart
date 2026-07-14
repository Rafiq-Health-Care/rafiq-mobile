import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:rafiq/core/errors/failure.dart';
import 'package:rafiq/core/errors/server_failure.dart';
import 'package:rafiq/core/errors/unknown_failure.dart';
import 'package:rafiq/features/schedule/data/datasources/schedule_remote_datasource.dart';
import 'package:rafiq/features/schedule/domain/entities/slot_entity.dart';
import 'package:rafiq/features/schedule/domain/repositories/schedule_repository.dart';

class ScheduleRepositoryImpl implements ScheduleRepository {
  final ScheduleRemoteDataSource remoteDataSource;

  const ScheduleRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, List<SlotEntity>>> getWeeklySchedule({
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    try {
      final slots = <SlotEntity>[];
      var page = 0;
      var isLast = false;

      while (!isLast) {
        final result = await remoteDataSource.searchSlots(
          startDate: startDate,
          endDate: endDate,
          page: page,
        );
        slots.addAll(result.content);
        isLast = result.lastPage || result.content.isEmpty;
        page++;
      }

      return Right(slots);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }
}
