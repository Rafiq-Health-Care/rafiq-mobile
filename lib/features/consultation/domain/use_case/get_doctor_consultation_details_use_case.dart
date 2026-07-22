import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:rafiq/core/errors/failure.dart';
import 'package:rafiq/features/consultation/domain/entity/doctor_consultation_entity.dart';
import 'package:rafiq/features/consultation/domain/repository/consultation_repository.dart';

class GetDoctorConsultationDetailsUseCase {
  final ConsultationRepository repository;
  GetDoctorConsultationDetailsUseCase(this.repository);

  Future<Either<Failure, DoctorConsultationEntity>> call(
    GetDoctorConsultationDetailsParams params,
  ) {
    return repository.doctorConsultationDetails(slotId: params.slotId);
  }
}

class GetDoctorConsultationDetailsParams extends Equatable {
  final String slotId;

  const GetDoctorConsultationDetailsParams({required this.slotId});

  @override
  List<Object?> get props => [slotId];
}
