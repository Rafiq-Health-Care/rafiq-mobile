part of 'lab_test_cubit.dart';

@immutable
sealed class LabTestState {}

final class LabTestInitial extends LabTestState {}

final class LabTestLoading extends LabTestState {}

final class LabTestSuccess extends LabTestState {}

final class LabTestError extends LabTestState {
  final String message;
  LabTestError(this.message);
}

final class LabTestEmpty extends LabTestState {}
