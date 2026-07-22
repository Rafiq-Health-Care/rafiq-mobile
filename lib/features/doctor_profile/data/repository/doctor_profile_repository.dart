import 'package:dartz/dartz.dart';
import 'package:rafiq/core/errors/failure.dart';
import 'package:rafiq/features/doctor_profile/data/models/update_basic_info_request.dart';
import 'package:rafiq/features/doctor_profile/data/models/upsert_experience_request.dart';
import 'package:rafiq/features/doctor_profile/data/service/doctor_profile_service.dart';

class DoctorProfileRepository {
  final DoctorProfileService service;
  DoctorProfileRepository(this.service);

  Future<Either<Failure, void>> updateBasicInfo(
    UpdateBasicInfoRequest request,
  ) {
    return service.updateBasicInfo(request.toJson());
  }

  Future<Either<Failure, void>> updateBiography(String biography) {
    return service.updateBiography(biography);
  }

  Future<Either<Failure, void>> setPrice(double price) {
    return service.setPrice(price);
  }

  Future<Either<Failure, void>> addExperience(
    UpsertExperienceRequest request,
  ) {
    return service.addExperience(request.toJson());
  }

  Future<Either<Failure, void>> updateExperience(
    String expId,
    UpsertExperienceRequest request,
  ) {
    return service.updateExperience(expId, request.toJson());
  }
}
