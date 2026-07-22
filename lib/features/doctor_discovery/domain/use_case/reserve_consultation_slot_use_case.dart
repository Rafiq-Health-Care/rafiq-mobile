import 'package:dartz/dartz.dart';
import 'package:rafiq/core/errors/failure.dart';
import 'package:rafiq/features/doctor_discovery/domain/entity/payment_entity.dart';
import 'package:rafiq/features/doctor_discovery/domain/params/reserve_consultation_slot_params.dart';
import 'package:rafiq/features/doctor_discovery/domain/repository/doctor_discovery_repository.dart';

class ReserveConsultationSlotUseCase {
  final DoctorDiscoveryRepository repository;

  ReserveConsultationSlotUseCase(this.repository);

  Future<Either<Failure, PaymentEntity>> call(
    ReserveConsultationSlotParams params,
  ) async {
    return await repository.reserveConsultationSlot(
      reserveConsultationSlotBody: params.toBodyJson(),
    );
  }
}
