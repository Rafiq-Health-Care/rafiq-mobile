import 'package:dartz/dartz.dart';
import 'package:rafiq/core/errors/failure.dart';
import 'package:rafiq/core/errors/server_failure.dart';
import 'package:rafiq/features/Consultation/data/data_source/remote_data_source.dart';
import 'package:rafiq/features/Consultation/domain/entity/doctor_details_entity.dart';
import 'package:rafiq/features/Consultation/domain/entity/paginated_doctors_entity.dart';
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
      return Left(ServerFailure(e.toString()));
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
      return Left(ServerFailure(e.toString()));
    }
  }
}
