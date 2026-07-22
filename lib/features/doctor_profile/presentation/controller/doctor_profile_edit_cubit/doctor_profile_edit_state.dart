part of 'doctor_profile_edit_cubit.dart';

@immutable
sealed class DoctorProfileEditState {}

final class DoctorProfileEditInitial extends DoctorProfileEditState {}

final class DoctorProfileEditSubmitting extends DoctorProfileEditState {}

final class DoctorProfileEditSuccess extends DoctorProfileEditState {}

final class DoctorProfileEditFailure extends DoctorProfileEditState {
  final String message;
  DoctorProfileEditFailure(this.message);
}
