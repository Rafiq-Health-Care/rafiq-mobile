import 'package:dartz/dartz.dart';
import 'package:rafiq/core/errors/failure.dart';
import 'package:rafiq/features/Consultation/data/data_source/remote_data_source.dart';
import 'package:rafiq/features/Consultation/domain/entity/consultation_details_entity.dart';
import 'package:rafiq/features/Consultation/domain/entity/doctor_details_entity.dart';
import 'package:rafiq/features/Consultation/domain/entity/paginated_consultation_entity.dart';
import 'package:rafiq/features/Consultation/domain/entity/paginated_doctors_entity.dart';
import 'package:rafiq/features/Consultation/domain/entity/payment_entity.dart';
import 'package:rafiq/features/Consultation/domain/entity/slot_pagination_entity.dart';
import 'package:rafiq/features/Consultation/domain/params/patient_consultation_params.dart';
import 'package:rafiq/features/Consultation/domain/repository/repository.dart';

class RepositoryImpl implements Repository {
  final RemoteDataSource remoteDataSource;

  RepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, PaginatedDoctorsEntity>> searchDoctors({
    required int page,
    required int size,
    required Map<String, dynamic> filterBody,
  }) async {
    try {
      final remoteData = await remoteDataSource.searchDoctors(
        page: page,
        size: size,
        filterBody: filterBody,
      );
      return Right(remoteData.toEntity());
    } catch (e) {
      return Left(e as Failure);
    }
  }

  @override
  Future<Either<Failure, DoctorDetailsEntity>> getDoctorDetails({
    required String id,
  }) async {
    try {
      final remoteData = await remoteDataSource.getDoctorDetails(id: id);
      return Right(remoteData.toEntity());
    } catch (e) {
      return Left(e as Failure);
    }
  }

  @override
  Future<Either<Failure, SlotPaginationEntity>> patientSeeDoctorsSlots({
    required String doctorId,
    required int page,
    required int size,
  }) async {
    try {
      final remoteData = await remoteDataSource.patientSeeDoctorsSlots(
        doctorId: doctorId,
        page: page,
        size: size,
      );
      return Right(remoteData.toEntity());
    } catch (e) {
      return Left(e as Failure);
    }
  }

  @override
  Future<Either<Failure, PaymentEntity>> reserveConsultationSlot({
    required Map<String, dynamic> reserveConsultationSlotBody,
  }) async {
    try {
      final remoteData = await remoteDataSource.reserveConsultationSlot(
        reserveConsultationSlotBody: reserveConsultationSlotBody,
      );
      return Right(remoteData.toEntity());
    } catch (e) {
      return Left(e as Failure);
    }
  }

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
  Future<Either<Failure, ConsultationDetailsEntity>> consultationDetails({
    required String id,
  }) async {
    try {
      final remoteData = await remoteDataSource.consultationDetails(id: id);
      return Right(remoteData.toEntity());
    } catch (e) {
      return Left(e as Failure);
    }
  }
}
