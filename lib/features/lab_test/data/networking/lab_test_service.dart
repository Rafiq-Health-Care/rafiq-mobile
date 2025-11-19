import 'package:dio/dio.dart';
import 'package:rafiq/core/networking/api_constants.dart';
import 'package:rafiq/core/networking/api_service.dart';
import 'package:rafiq/features/lab_test/data/models/lab_test_upload_request.dart';
import 'package:rafiq/features/lab_test/data/models/lab_test_get_all_request.dart';
import 'package:rafiq/features/lab_test/data/models/lab_test_results_model.dart';

class LabTestService {
  final _api = ApiService.instance;

  Future<dynamic> getAllLabTests(LabTestGetAllRequest queryParameters) async {
    try {
      Response response = await _api.get(
        ApiConstants.labTest,
        queryParameters: queryParameters.toMap(),
      );
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteAllTestLabs() async {
    try {
      await _api.delete(ApiConstants.labTest);
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> getLabTestDetails(String testId) async {
    try {
      Response response = await _api.get('${ApiConstants.labTest}/$testId');
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteTestLabDetails(String testId) async {
    try {
      await _api.delete('${ApiConstants.labTest}/$testId');
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> uploadTestLab(LabTestUploadRequest body) async {
    final formData = await body.toFormData();

    try {
      Response response = await _api.post(
        ApiConstants.uploadLabTest,
        data: formData,
        options: Options(headers: {'Content-Type': 'multipart/form-data'}),
      );
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> saveLabTestResults(LabTestResultsModel body) async {
    try {
      await _api.post(ApiConstants.labTestResults, data: body.toJson());
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateLabTestResults(LabTestResultsModel body) async {
    try {
      await _api.put(
        '${ApiConstants.labTestResults}/${body.testId}',
        data: body.toJson(),
      );
    } catch (e) {
      rethrow;
    }
  }
}
