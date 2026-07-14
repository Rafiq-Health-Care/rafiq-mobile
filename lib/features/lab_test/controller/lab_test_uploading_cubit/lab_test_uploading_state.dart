part of 'lab_test_uploading_cubit.dart';

@immutable
sealed class LabTestUploadingState {}

final class LabTestUploadingInitial extends LabTestUploadingState {}

final class LabTestUploadingLoading extends LabTestUploadingState {}

final class LabTestUploadingSuccess extends LabTestUploadingState {
  final LabTestUploadResponse response;
  LabTestUploadingSuccess(this.response);
}

final class LabTestUploadingError extends LabTestUploadingState {
  final String message;
  LabTestUploadingError(this.message);
}
