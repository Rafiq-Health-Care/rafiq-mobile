part of 'specialization_cubit.dart';

@immutable
sealed class SpecializationState {}

final class SpecializationInitial extends SpecializationState {}

final class SpecializationLoading extends SpecializationState {}

final class SpecializationSuccess extends SpecializationState {
  final List<String> specializations;
  SpecializationSuccess(this.specializations);
}

final class SpecializationFailure extends SpecializationState {
  final String message;
  SpecializationFailure(this.message);
}
