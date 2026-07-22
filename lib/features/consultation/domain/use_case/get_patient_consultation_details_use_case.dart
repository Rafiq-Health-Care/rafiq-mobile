import 'package:dartz/dartz.dart';
import 'package:rafiq/core/errors/failure.dart';
import 'package:rafiq/features/consultation/domain/entity/consultation_details_entity.dart';
import 'package:rafiq/features/consultation/domain/repository/consultation_repository.dart';

class GetPatientConsultationDetailsUseCase {
  final ConsultationRepository repository;

  GetPatientConsultationDetailsUseCase(this.repository);

  Future<Either<Failure, ConsultationDetailsEntity>> call(String id) {
    return repository.patientConsultationDetails(id: id);
  }
}
