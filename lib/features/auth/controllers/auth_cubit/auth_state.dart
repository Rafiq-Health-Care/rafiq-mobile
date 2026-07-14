part of 'auth_cubit.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}

final class LogInSuccess extends AuthState {
  final String role;
  LogInSuccess({required this.role});
}

final class PatientSignUpSuccess extends AuthState {
  final String role;
  PatientSignUpSuccess({required this.role});
}

final class DoctorSignUpSuccess extends AuthState {
  final String role;
  DoctorSignUpSuccess({required this.role});
}

final class UserVerificationSuccess extends AuthState {}

final class UserVerificationResendSuccess extends AuthState {}

final class GoogleAuthSuccess extends AuthState {}

final class LogoutSuccess extends AuthState {}

final class AuthFailure extends AuthState {
  final String message;
  AuthFailure(this.message);
}
