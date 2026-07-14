import 'package:dartz/dartz.dart';
import 'package:rafiq/core/errors/failure.dart';
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

  Future<Either<Failure, LabTestGetAllResponse>> getAllLabTests(
    LabTestGetAllRequest request,
  ) async {
    final rowData = await labTestService.getAllLabTests(request);
    return rowData.fold(
      (failure) => Left(failure),
      (data) => Right(LabTestGetAllResponse.fromJson(data)),
    );
  }

  Future<Either<Failure, void>> deleteAllTestLabs() async {
    final rowData = await labTestService.deleteAllTestLabs();
    return rowData.fold((failure) => Left(failure), (_) => Right(null));
  }

  Future<Either<Failure, LabTestDetailsModel>> getTestLabDetails(
    String testId,
  ) async {
    final rowData = await labTestService.getLabTestDetails(testId);
    return rowData.fold(
      (failure) => Left(failure),
      (data) => Right(LabTestDetailsModel.fromJson(data)),
    );
  }

  Future<Either<Failure, void>> deleteTestLab(String testId) async {
    final rowData = await labTestService.deleteTestLabDetails(testId);
    return rowData.fold((failure) => Left(failure), (_) => Right(null));
  }

  Future<Either<Failure, LabTestUploadResponse>> uploadTestLab(
    LabTestUploadRequest request,
  ) async {
    final rowData = await labTestService.uploadTestLab(request);
    return rowData.fold(
      (failure) => Left(failure),
      (data) => Right(LabTestUploadResponse.fromJson(data)),
    );
  }

  Future<Either<Failure, void>> saveLabTestResults(
    LabTestResultsModel request,
  ) async {
    final rowData = await labTestService.saveLabTestResults(request);
    return rowData.fold(
      (failure) => Left(failure),
      (data) => Right(null),
    );
  }

  Future<Either<Failure, LabTestDetailsModel>> updateLabTestResults(
    LabTestResultsModel request,
    String testId,
  ) async {
    final rowData = await labTestService.updateLabTestResults(request, testId);
    return rowData.fold(
      (failure) => Left(failure),
      (data) => Right(LabTestDetailsModel.fromJson(data)),
    );
  }

  // Future<Either<Failure, LabTestFileResponse>> getLAbTestFile(
  //   String fileId,
  // ) async {
  //   final rowData = await labTestService.getLabTestFile(fileId);
  //   return rowData.fold(
  //     (failure) => Left(failure),
  //     (data) => Right(LabTestFileResponse.fromJson(data)),
  //   );
  // }
}
