import 'package:dartz/dartz.dart';
import 'package:rafiq/core/errors/failure.dart';
import 'package:rafiq/core/networking/api_constants.dart';
import 'package:rafiq/core/networking/api_service.dart';

class LandingService {
  final ApiService apiService;
  LandingService({required this.apiService});

  Future<Either<Failure, String>> refresh() async {
    try {
      final response = await apiService.post(ApiConstants.authRefresh);
      return Right(response.data['role']);
    } catch (e) {
      return Left(e as Failure);
    }
  }
}
