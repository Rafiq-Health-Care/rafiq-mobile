import 'package:dartz/dartz.dart';
import 'package:rafiq/core/errors/failure.dart';
import 'package:rafiq/features/doctor_discovery/data/data_source/doctor_discovery_remote_data_source.dart';
import 'package:rafiq/features/doctor_discovery/domain/entity/doctor_details_entity.dart';
import 'package:rafiq/features/doctor_discovery/domain/entity/paginated_doctors_entity.dart';
import 'package:rafiq/features/doctor_discovery/domain/entity/payment_entity.dart';
import 'package:rafiq/features/doctor_discovery/domain/entity/slot_pagination_entity.dart';
import 'package:rafiq/features/doctor_discovery/domain/repository/doctor_discovery_repository.dart';

class DoctorDiscoveryRepositoryImpl implements DoctorDiscoveryRepository {
  final DoctorDiscoveryRemoteDataSource remoteDataSource;

  DoctorDiscoveryRepositoryImpl(this.remoteDataSource);

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
}
