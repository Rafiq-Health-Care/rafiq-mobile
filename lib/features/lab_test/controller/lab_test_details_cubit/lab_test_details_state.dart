part of 'lab_test_details_cubit.dart';

@immutable
sealed class LabTestDetailsState {}

final class LabTestDetailsInitial extends LabTestDetailsState {}

final class LabTestDetailsLoading extends LabTestDetailsState {}

final class LabTestDetailsLoaded extends LabTestDetailsState {
  final LabTestGetDetailsResponse response;
  LabTestDetailsLoaded(this.response);
}

final class LabTestDetailsUpdated extends LabTestDetailsState {}

final class LabTestDetailsError extends LabTestDetailsState {
  final String message;
  LabTestDetailsError(this.message);
}
