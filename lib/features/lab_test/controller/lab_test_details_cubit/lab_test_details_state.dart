part of 'lab_test_details_cubit.dart';

@immutable
sealed class LabTestDetailsState {}

final class LabTestDetailsInitial extends LabTestDetailsState {}

final class LabTestDetailsLoading extends LabTestDetailsState {}

final class LabTestDetailsSuccess extends LabTestDetailsState {}

final class LabTestDetailsError extends LabTestDetailsState {
  final String message;
  LabTestDetailsError(this.message);
}


