import 'package:rafiq/features/lab_test/data/models/lab_test_file_response.dart';
import 'package:rafiq/features/lab_test/data/models/lab_test_get_all_request.dart';
import 'package:rafiq/features/lab_test/data/models/lab_test_get_all_response.dart';
import 'package:rafiq/features/lab_test/data/models/lab_test_details_model.dart';
import 'package:rafiq/features/lab_test/data/models/lab_test_results_model.dart';
import 'package:rafiq/features/lab_test/data/models/lab_test_upload_request.dart';
import 'package:rafiq/features/lab_test/data/models/lab_test_upload_response.dart';
import 'package:rafiq/features/lab_test/data/networking/lab_test_service.dart';

class LabTestRepository {
  final LabTestService labTestService;
  LabTestRepository({required this.labTestService});

  Future<LabTestGetAllResponse> getAllLabTests(
    LabTestGetAllRequest request,
  ) async {
    final rowData = await labTestService.getAllLabTests(request);
    return LabTestGetAllResponse.fromJson(rowData);
  }

  Future<void> deleteAllTestLabs() async {
    await labTestService.deleteAllTestLabs();
  }

  Future<LabTestDetailsModel> getTestLabDetails(String testId) async {
    final rowData = await labTestService.getLabTestDetails(testId);
    return LabTestDetailsModel.fromJson(rowData);
  }

  Future<void> deleteTestLab(String testId) async {
    await labTestService.deleteTestLabDetails(testId);
  }

  Future<LabTestUploadResponse> uploadTestLab(
    LabTestUploadRequest request,
  ) async {
    final rowData = await labTestService.uploadTestLab(request);
    return LabTestUploadResponse.fromJson(rowData);
  }

  Future<LabTestDetailsModel> saveLabTestResults(
    LabTestResultsModel request,
  ) async {
    final rawData = await labTestService.saveLabTestResults(request);
    return LabTestDetailsModel.fromJson(rawData);
  }

  Future<LabTestDetailsModel> updateLabTestResults(
    LabTestResultsModel request,
    String testId,
  ) async {
    final rawData = await labTestService.updateLabTestResults(request, testId);
    return LabTestDetailsModel.fromJson(rawData);
  }

  Future<LabTestFileResponse> getLAbTestFile(String fileId) async {
    final rawData = await labTestService.getLabTestFile(fileId);
    return LabTestFileResponse.fromJson(rawData);
  }
}
