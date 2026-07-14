part of 'lab_test_details_cubit.dart';

@immutable
sealed class LabTestDetailsState {}

final class LabTestDetailsInitial extends LabTestDetailsState {}

final class LabTestDetailsLoading extends LabTestDetailsState {}

final class LabTestDetailsLoaded extends LabTestDetailsState {
  final LabTestDetailsModel response;
  LabTestDetailsLoaded(this.response);
}

final class LabTestDetailsUpdated extends LabTestDetailsState {
  final LabTestDetailsModel response;
  LabTestDetailsUpdated(this.response);
}

final class LabTestDetailsError extends LabTestDetailsState {
  final String message;
  LabTestDetailsError(this.message);
}
