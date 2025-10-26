import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rafiq/features/auth/data/models/user_response.dart';
import 'package:rafiq/features/auth/data/models/user_verification_request.dart';
import 'package:rafiq/features/auth/data/networking/auth_service.dart';
import 'package:rafiq/features/auth/data/repository/auth_repository.dart';

part 'otp_state.dart';

class OtpCubit extends Cubit<OtpState> {
  final AuthService authService;
  final AuthRepository authRepository;
  OtpCubit(this.authService, this.authRepository) : super(OtpInitial());
  late UserResponse userResponse;

  void userVerification(UserVerificationRequest body) {
    emit(OtpLoading());
    authRepository
        .userVerificationRepository(body)
        .then((value) {
          userResponse = value;
          emit(OtpSuccess());
        })
        .catchError((e) {
          emit(OtpFailure(e.toString()));
        });
  }

  void sendNewOtp(String email) {
    emit(OtpLoading());
    authService
        .sendNewOtp(email)
        .then((_) {
          emit(OtpSuccess());
        })
        .catchError((e) {
          emit(OtpFailure(e.toString()));
        });
  }

  static OtpCubit get(context) => BlocProvider.of(context);
}
