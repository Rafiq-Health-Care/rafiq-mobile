import 'package:dartz/dartz.dart';
import 'package:rafiq/core/errors/failure.dart';
import 'package:rafiq/features/Consultation/domain/entity/doctor_details_entity.dart';
import 'package:rafiq/features/Consultation/domain/repository/repository.dart';

class GetDoctorDetailsUseCase {
  final Repository repository;

  GetDoctorDetailsUseCase(this.repository);

  Future<Either<Failure, DoctorDetailsEntity>> call(String id) {
    return repository.getDoctorDetails(id: id);
  }
}
