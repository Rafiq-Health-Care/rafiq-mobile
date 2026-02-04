import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rafiq/features/auth/data/models/reset_password_request.dart';
import 'package:rafiq/features/auth/data/networking/auth_service.dart';
import 'package:rafiq/features/auth/data/repository/auth_repository.dart';

part 'forget_password_state.dart';

class ForgetPasswordCubit extends Cubit<ForgetPasswordState> {
  final AuthService authService;
  final AuthRepository authRepository;
  ForgetPasswordCubit(this.authService, this.authRepository)
    : super(ForgetPasswordInitial());

  void forgetPassword(String email) {
    emit(ForgetPasswordLoading());
    authService
        .forgetPassword(email)
        .then((value) {
          emit(ForgetPasswordEmailSent());
        })
        .catchError((e) {
          emit(ForgetPasswordError(e.toString()));
        });
  }

  void resetPassword(ResetPasswordRequest request) {
    emit(ForgetPasswordLoading());
    authService
        .resetPassword(request)
        .then((value) {
          emit(ForgetPasswordChanged());
        })
        .catchError((e) {
          emit(ForgetPasswordError(e.toString()));
        });
  }

  static ForgetPasswordCubit get(context) => BlocProvider.of(context);
}
