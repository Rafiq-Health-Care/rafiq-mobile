import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rafiq/features/auth/data/models/change_password_request.dart';
import 'package:rafiq/features/auth/data/models/user_verification_request.dart';
import 'package:rafiq/features/auth/data/networking/auth_service.dart';
import 'package:rafiq/features/auth/data/repository/auth_repository.dart';

part 'forget_password_state.dart';

class ForgetPasswordCubit extends Cubit<ForgetPasswordState> {
  final AuthService authService;
  final AuthRepository authRepository;
  ForgetPasswordCubit(this.authService, this.authRepository)
    : super(ForgetPasswordInitial());

  String? _email;
  String? _accessToken;

  void forgetPassword(String email) {
    emit(ForgetPasswordLoading());
    authService
        .forgetPassword(email)
        .then((value) {
          _email = email;
          emit(ForgetPasswordEmailSent());
        })
        .catchError((e) {
          emit(ForgetPasswordError(e.toString()));
        });
  }

  void userVerify(String otp) {
    emit(ForgetPasswordLoading());
    authRepository
        .userVerify(UserVerificationRequest(email: _email!, otp: otp))
        .then((value) {
          _accessToken = value;
          emit(ForgetPasswordOtpVerified());
        })
        .catchError((e) {
          emit(ForgetPasswordError(e.toString()));
        });
  }

  void changePassword(String newPassword) {
    emit(ForgetPasswordLoading());
    authService
        .changePassword(
          ChangePasswordRequest(
            accessToken: _accessToken!,
            newPassword: newPassword,
          ),
        )
        .then((value) {
          emit(ForgetPasswordChanged());
        })
        .catchError((e) {
          emit(ForgetPasswordError(e.toString()));
        });
  }

  static ForgetPasswordCubit get(context) => BlocProvider.of(context);
}
