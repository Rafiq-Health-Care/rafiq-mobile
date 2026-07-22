import 'package:dartz/dartz.dart';
import 'package:rafiq/core/errors/failure.dart';
import 'package:rafiq/core/networking/api_constants.dart';
import 'package:rafiq/core/networking/api_service.dart';

class DoctorProfileService {
  final ApiService _api;
  DoctorProfileService({required ApiService api}) : _api = api;

  Future<Either<Failure, void>> updateBasicInfo(
    Map<String, dynamic> body,
  ) async {
    try {
      await _api.put(ApiConstants.doctorBasicInfo, data: body);
      return right(null);
    } catch (e) {
      return left(e as Failure);
    }
  }

  Future<Either<Failure, void>> updateBiography(String biography) async {
    try {
      await _api.patch(
        ApiConstants.doctorBiography,
        data: {'biography': biography},
      );
      return right(null);
    } catch (e) {
      return left(e as Failure);
    }
  }

  Future<Either<Failure, void>> setPrice(double price) async {
    try {
      await _api.put(ApiConstants.doctorPrice, data: {'price': price});
      return right(null);
    } catch (e) {
      return left(e as Failure);
    }
  }

  Future<Either<Failure, void>> addExperience(
    Map<String, dynamic> body,
  ) async {
    try {
      await _api.post(ApiConstants.doctorExperience, data: body);
      return right(null);
    } catch (e) {
      return left(e as Failure);
    }
  }

  Future<Either<Failure, void>> updateExperience(
    String expId,
    Map<String, dynamic> body,
  ) async {
    try {
      await _api.put(ApiConstants.doctorExperienceById(expId), data: body);
      return right(null);
    } catch (e) {
      return left(e as Failure);
    }
  }
}
