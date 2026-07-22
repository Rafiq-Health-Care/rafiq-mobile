import 'package:dartz/dartz.dart';
import 'package:rafiq/core/errors/failure.dart';
import 'package:rafiq/features/consultation/data/data_source/consultation_remote_data_source.dart';
import 'package:rafiq/features/consultation/domain/entity/consultation_details_entity.dart';
import 'package:rafiq/features/consultation/domain/entity/doctor_consultation_entity.dart';
import 'package:rafiq/features/consultation/domain/entity/paginated_consultation_entity.dart';
import 'package:rafiq/features/consultation/domain/params/patient_consultation_params.dart';
import 'package:rafiq/features/consultation/domain/repository/consultation_repository.dart';

class ConsultationRepositoryImpl implements ConsultationRepository {
  final ConsultationRemoteDataSource remoteDataSource;

  ConsultationRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, PaginatedConsultationEntity>> patientConsultations({
    required PatientConsultationParams params,
  }) async {
    try {
      final remoteData = await remoteDataSource.patientConsultations(
        page: params.page,
        size: params.size,
        status: params.status.name.toUpperCase(),
      );
      return Right(remoteData.toEntity());
    } catch (e) {
      return Left(e as Failure);
    }
  }

  @override
  Future<Either<Failure, ConsultationDetailsEntity>> patientConsultationDetails({
    required String id,
  }) async {
    try {
      final remoteData = await remoteDataSource.patientConsultationDetails(
        id: id,
      );
      return Right(remoteData.toEntity());
    } catch (e) {
      return Left(e as Failure);
    }
  }

  @override
  Future<Either<Failure, DoctorConsultationEntity>> doctorConsultationDetails({
    required String slotId,
  }) async {
    try {
      final remoteData = await remoteDataSource.doctorConsultationDetails(
        slotId,
      );
      return Right(remoteData.toEntity());
    } catch (e) {
      return Left(e as Failure);
    }
  }

  @override
  Future<Either<Failure, void>> cancelConsultation({
    required String consultationId,
    String? reason,
  }) async {
    try {
      await remoteDataSource.cancelConsultation(consultationId, reason);
      return const Right(null);
    } catch (e) {
      return Left(e as Failure);
    }
  }
}
