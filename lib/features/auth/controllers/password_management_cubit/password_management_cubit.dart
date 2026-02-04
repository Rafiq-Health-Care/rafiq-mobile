import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rafiq/features/auth/data/models/reset_password_request.dart';
import 'package:rafiq/features/auth/data/networking/auth_service.dart';
import 'package:rafiq/features/auth/data/repository/auth_repository.dart';

part 'password_management_state.dart';

class PasswordManagementCubit extends Cubit<PasswordManagementState> {
  final AuthService authService;
  final AuthRepository authRepository;
  PasswordManagementCubit(this.authService, this.authRepository)
    : super(PasswordManagementInitial());

  void forgetPassword(String email) {
    emit(PasswordManagementLoading());
    authService
        .forgetPassword(email)
        .then((value) {
          emit(ForgetPasswordEmailSent());
        })
        .catchError((e) {
          emit(PasswordManagementError(e.toString()));
        });
  }

  void resetPassword(ResetPasswordRequest request) {
    emit(PasswordManagementLoading());
    authService
        .resetPassword(request)
        .then((value) {
          emit(PasswordChanged());
        })
        .catchError((e) {
          emit(PasswordManagementError(e.toString()));
        });
  }

  static PasswordManagementCubit get(context) => BlocProvider.of(context);
}
