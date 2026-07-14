import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rafiq/features/auth/data/models/reset_password_request.dart';
import 'package:rafiq/features/auth/data/networking/repository/auth_repository.dart';

part 'password_management_state.dart';

class PasswordManagementCubit extends Cubit<PasswordManagementState> {
  final AuthRepository authRepository;
  PasswordManagementCubit(this.authRepository)
    : super(PasswordManagementInitial());

  Future<void> forgetPassword(String email) async {
    emit(PasswordManagementLoading());
    final response = await authRepository.forgetPasswordRepository(email);
    response.fold(
      (failure) => emit(PasswordManagementError(failure.message)),
      (success) => emit(ForgetPasswordEmailSent()),
    );
  }

  Future<void> resetPassword(ResetPasswordRequest request) async {
    emit(PasswordManagementLoading());
    final response = await authRepository.resetPasswordRepository(request);
    response.fold(
      (failure) => emit(PasswordManagementError(failure.message)),
      (success) => emit(PasswordChanged()),
    );
  }

  static PasswordManagementCubit get(context) => BlocProvider.of(context);
}
