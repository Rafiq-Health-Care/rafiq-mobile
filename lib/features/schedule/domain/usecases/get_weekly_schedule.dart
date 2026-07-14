import 'package:dartz/dartz.dart';
import 'package:rafiq/core/errors/failure.dart';
import 'package:rafiq/features/schedule/domain/entities/slot_entity.dart';
import 'package:rafiq/features/schedule/domain/params/week_range_params.dart';
import 'package:rafiq/features/schedule/domain/repositories/schedule_repository.dart';



class GetWeeklySchedule {
  final ScheduleRepository repository;

  const GetWeeklySchedule(this.repository);

  Future<Either<Failure, List<SlotEntity>>> call(WeekRangeParams params) {
    return repository.getWeeklySchedule(
      startDate: params.startDate,
      endDate: params.endDate,
    );
  }
}
