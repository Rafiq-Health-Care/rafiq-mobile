import 'package:dartz/dartz.dart';
import 'package:rafiq/core/errors/failure.dart';
import 'package:rafiq/features/Consultation/domain/entity/paginated_consultation_entity.dart';
import 'package:rafiq/features/Consultation/domain/params/patient_consultation_params.dart';
import 'package:rafiq/features/Consultation/domain/repository/repository.dart';

class PatientConsultationUseCase {
  final Repository repository;
  PatientConsultationUseCase(this.repository);

  Future<Either<Failure, PaginatedConsultationEntity>> call(
    PatientConsultationParams params,
  ) {
    return repository.patientConsultations(params: params);
  }
}
