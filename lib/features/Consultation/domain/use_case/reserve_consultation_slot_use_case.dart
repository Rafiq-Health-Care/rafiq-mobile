import 'package:dartz/dartz.dart';
import 'package:rafiq/core/errors/failure.dart';
import 'package:rafiq/features/Consultation/domain/entity/payment_entity.dart';
import 'package:rafiq/features/Consultation/domain/params/reserve_consultation_slot_params.dart';
import 'package:rafiq/features/Consultation/domain/repository/repository.dart';

class ReserveConsultationSlotUseCase {
  final Repository repository;

  ReserveConsultationSlotUseCase(this.repository);

  Future<Either<Failure, PaymentEntity>> call(
    ReserveConsultationSlotParams params,
  ) async {
    return await repository.reserveConsultationSlot(
      reserveConsultationSlotBody: params.toBodyJson(),
    );
  }
}
