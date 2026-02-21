import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:rafiq/core/errors/failure.dart';
import 'package:rafiq/core/networking/api_constants.dart';
import 'package:rafiq/core/networking/api_service.dart';
import 'package:rafiq/features/lab_test/data/models/lab_test_upload_request.dart';
import 'package:rafiq/features/lab_test/data/models/lab_test_get_all_request.dart';
import 'package:rafiq/features/lab_test/data/models/lab_test_results_model.dart';

class LabTestService {
  final ApiService _api;
  LabTestService({required ApiService api}) : _api = api;

  Future<Either<Failure, dynamic>> getAllLabTests(
    LabTestGetAllRequest queryParameters,
  ) async {
    try {
      Response response = await _api.get(
        ApiConstants.labTest,
        queryParameters: queryParameters.toMap(),
      );
      return Right(response.data);
    } catch (e) {
      return Left(e as Failure);
    }
  }

  Future<Either<Failure, void>> deleteAllTestLabs() async {
    try {
      await _api.delete(ApiConstants.labTest);
      return Right(null);
    } catch (e) {
      return Left(e as Failure);
    }
  }

  Future<Either<Failure, dynamic>> getLabTestDetails(String testId) async {
    try {
      Response response = await _api.get('${ApiConstants.labTest}/$testId');
      return Right(response.data);
    } catch (e) {
      return Left(e as Failure);
    }
  }

  Future<Either<Failure, void>> deleteTestLabDetails(String testId) async {
    try {
      await _api.delete('${ApiConstants.labTest}/$testId');
      return Right(null);
    } catch (e) {
      return Left(e as Failure);
    }
  }

  Future<Either<Failure, dynamic>> uploadTestLab(
    LabTestUploadRequest body,
  ) async {
    final formData = await body.toFormData();

    try {
      Response response = await _api.post(
        ApiConstants.extractLabTestFile,
        data: formData,
        options: Options(headers: {'Content-Type': 'multipart/form-data'}),
      );
      return Right(response.data);
    } catch (e) {
      return Left(e as Failure);
    }
  }

  Future<Either<Failure, dynamic>> saveLabTestResults(
    LabTestResultsModel body,
  ) async {
    try {
      Response response = await _api.post(
        ApiConstants.labTestResults,
        data: body.toJson(),
      );
      return Right(response.data);
    } catch (e) {
      return Left(e as Failure);
    }
  }

  Future<Either<Failure, dynamic>> updateLabTestResults(
    LabTestResultsModel body,
    String testId,
  ) async {
    try {
      Response response = await _api.put(
        '${ApiConstants.updateLabTest}/$testId',
        data: body.toJson(),
      );
      return Right(response.data);
    } catch (e) {
      return Left(e as Failure);
    }
  }

  Future<Either<Failure, dynamic>> getLabTestFile(String fileId) async {
    try {
      Response response = await _api.get(
        '${ApiConstants.getLabTestFile}/$fileId',
      );
      return Right(response.data);
    } catch (e) {
      return Left(e as Failure);
    }
  }
}
