part of 'auth_cubit.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}

final class LogInSuccess extends AuthState {}

final class PatientSignUpSuccess extends AuthState {}

final class DoctorSignUpSuccess extends AuthState {}

final class UserVerificationSuccess extends AuthState {}

final class UserVerificationResendSuccess extends AuthState {}

final class GoogleAuthSuccess extends AuthState {}

final class LogoutSuccess extends AuthState {}

final class AuthFailure extends AuthState {
  final String message;
  AuthFailure(this.message);
}
