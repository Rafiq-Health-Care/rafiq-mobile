import 'package:dartz/dartz.dart';
import 'package:rafiq/core/errors/failure.dart';
import 'package:rafiq/features/Consultation/domain/entity/consultation_details_entity.dart';
import 'package:rafiq/features/Consultation/domain/repository/repository.dart';

class ConsultationDetailsUseCase {
  final Repository repository;

  ConsultationDetailsUseCase(this.repository);

  Future<Either<Failure, ConsultationDetailsEntity>> call(String id) {
    return repository.consultationDetails(id: id);
  }
}
