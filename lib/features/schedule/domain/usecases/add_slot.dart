import 'package:dartz/dartz.dart';
import 'package:rafiq/core/errors/failure.dart';
import 'package:rafiq/features/schedule/domain/params/add_slot_params.dart';
import 'package:rafiq/features/schedule/domain/repositories/schedule_repository.dart';

class AddSlot {
  final ScheduleRepository repository;

  const AddSlot(this.repository);

  Future<Either<Failure, void>> call(AddSlotParams params) {
    return repository.addSlot(
      startTime: params.startTime,
      durationInMinutes: params.durationInMinutes,
    );
  }
}
