part of 'forget_password_cubit.dart';

@immutable
sealed class ForgetPasswordState {}

final class ForgetPasswordInitial extends ForgetPasswordState {}

final class ForgetPasswordLoading extends ForgetPasswordState {}

final class ForgetPasswordEmailSent extends ForgetPasswordState {}

final class ForgetPasswordOtpVerified extends ForgetPasswordState {}

final class ForgetPasswordChanged extends ForgetPasswordState {}

final class ForgetPasswordError extends ForgetPasswordState {
  final String message;
  ForgetPasswordError(this.message);
}
