import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rafiq/core/networking/api_service.dart';
import 'package:rafiq/features/lab_test/data/models/lab_test_upload_request.dart';
import 'package:rafiq/features/lab_test/data/models/lab_test_upload_response.dart';
import 'package:rafiq/features/lab_test/data/repository/lab_test_repository.dart';

part 'lab_test_uploading_state.dart';

class LabTestUploadingCubit extends Cubit<LabTestUploadingState> {
  final LabTestRepository labTestRepository;

  LabTestUploadingCubit(this.labTestRepository)
    : super(LabTestUploadingInitial());

  void uploadTestLab(LabTestUploadRequest request) {
    emit(LabTestUploadingLoading());
    labTestRepository
        .uploadTestLab(request)
        .then((response) {
          emit(LabTestUploadingSuccess(response));
        })
        .catchError((error) {
          emit(LabTestUploadingError(error.toString()));
        });
  }

  Future<void> downloadLabTestFile(String fileId, BuildContext context) async {
    try {
      final labTestFile = await labTestRepository.getLAbTestFile(fileId);
      if (context.mounted) {
        _downloadFile(labTestFile.fileUrl, labTestFile.fileName, context);
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> _downloadFile(
    String url,
    String fileName,
    BuildContext context,
  ) async {
    try {
      final savePath = await ApiService.instance.downloadFile(url, fileName);

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('File downloaded to: $savePath')),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Download failed: $e')));
      }
    }
  }

  static LabTestUploadingCubit get(context) => BlocProvider.of(context);
}
