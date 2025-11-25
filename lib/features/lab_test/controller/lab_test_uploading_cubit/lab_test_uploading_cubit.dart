import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

  static LabTestUploadingCubit get(context) => BlocProvider.of(context);
}
