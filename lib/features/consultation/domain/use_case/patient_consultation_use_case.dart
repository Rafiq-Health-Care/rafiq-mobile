import 'package:dartz/dartz.dart';
import 'package:rafiq/core/errors/failure.dart';
import 'package:rafiq/features/consultation/domain/entity/paginated_consultation_entity.dart';
import 'package:rafiq/features/consultation/domain/params/patient_consultation_params.dart';
import 'package:rafiq/features/consultation/domain/repository/consultation_repository.dart';

class PatientConsultationUseCase {
  final ConsultationRepository repository;
  PatientConsultationUseCase(this.repository);

  Future<Either<Failure, PaginatedConsultationEntity>> call(
    PatientConsultationParams params,
  ) {
    return repository.patientConsultations(params: params);
  }
}
