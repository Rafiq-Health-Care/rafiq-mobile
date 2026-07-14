import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rafiq/features/lab_test/data/dummy/dummy_lab_test.dart';
import 'package:rafiq/features/lab_test/data/models/lab_test_upload_request.dart';
import 'package:rafiq/features/lab_test/data/models/lab_test_upload_response.dart';
import 'package:rafiq/features/lab_test/data/repository/lab_test_repository.dart';

part 'lab_test_uploading_state.dart';

class LabTestUploadingCubit extends Cubit<LabTestUploadingState> {
  final LabTestRepository labTestRepository;

  LabTestUploadingCubit(this.labTestRepository)
    : super(LabTestUploadingInitial());

  Future<void> uploadTestLab(LabTestUploadRequest request) async {
    emit(LabTestUploadingLoading());
    await Future.delayed(Duration(seconds: 2));
    emit(
      LabTestUploadingSuccess(
        LabTestUploadResponse(
          tests: labTestDetailsModel.tests,
          fileId: labTestDetailsModel.fileId,
        ),
      ),
    );
    // final response = await labTestRepository.uploadTestLab(request);
    // response.fold((failure) {
    //   // emit(LabTestUploadingError(failure.message));
    // }, (data) => emit(LabTestUploadingSuccess(data)));
  }

  // Future<void> downloadLabTestFile(String fileId, BuildContext context) async {
  //   final labTestFile = await labTestRepository.getLAbTestFile(fileId);
  //   labTestFile.fold(
  //     (failure) => emit(LabTestUploadingError(failure.message)),
  //     (labTestFile) async {
  //       if (context.mounted) {
  //         await _downloadFile(
  //           labTestFile.fileUrl,
  //           labTestFile.fileName,
  //           context,
  //         );
  //       }
  //     },
  //   );
  // }

  // Future<void> _downloadFile(
  //   String url,
  //   String fileName,
  //   BuildContext context,
  // ) async {
  //   try {
  //     final savePath = await ApiService.instance.downloadFile(url, fileName);

  //     if (context.mounted) {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(content: Text('File downloaded to: $savePath')),
  //       );
  //     }
  //   } catch (e) {
  //     if (context.mounted) {
  //       ScaffoldMessenger.of(
  //         context,
  //       ).showSnackBar(SnackBar(content: Text('Download failed: $e')));
  //     }
  //   }
  // }

  static LabTestUploadingCubit get(context) => BlocProvider.of(context);
}
