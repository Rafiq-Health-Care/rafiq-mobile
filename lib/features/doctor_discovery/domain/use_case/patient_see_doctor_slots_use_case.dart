import 'package:dartz/dartz.dart';
import 'package:rafiq/core/errors/failure.dart';
import 'package:rafiq/features/doctor_discovery/domain/entity/slot_pagination_entity.dart';
import 'package:rafiq/features/doctor_discovery/domain/params/patient_see_doctor_slots_params.dart';
import 'package:rafiq/features/doctor_discovery/domain/repository/doctor_discovery_repository.dart';

class PatientSeeDoctorSlotsUseCase {
  final DoctorDiscoveryRepository repository;

  PatientSeeDoctorSlotsUseCase(this.repository);

  Future<Either<Failure, SlotPaginationEntity>> call({
    required PatientSeeDoctorSlotsParams params,
  }) async {
    return await repository.patientSeeDoctorsSlots(
      doctorId: params.doctorId,
      page: params.page,
      size: params.size,
    );
  }
}
