part of 'password_management_cubit.dart';

@immutable
sealed class PasswordManagementState {}

final class PasswordManagementInitial extends PasswordManagementState {}

final class PasswordManagementLoading extends PasswordManagementState {}

final class ForgetPasswordEmailSent extends PasswordManagementState {}

final class PasswordChanged extends PasswordManagementState {}

final class PasswordManagementError extends PasswordManagementState {
  final String message;
  PasswordManagementError(this.message);
}
