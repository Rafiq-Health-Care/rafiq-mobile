import 'package:dartz/dartz.dart';
import 'package:rafiq/core/errors/failure.dart';
import 'package:rafiq/features/schedule/domain/entities/slot_entity.dart';

abstract class ScheduleRepository {
  Future<Either<Failure, List<SlotEntity>>> getWeeklySchedule({
    required DateTime startDate,
    required DateTime endDate,
  });
}
