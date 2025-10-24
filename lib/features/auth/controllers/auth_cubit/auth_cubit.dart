import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rafiq/features/auth/data/models/doctor_sign_up_request.dart';
import 'package:rafiq/features/auth/data/models/login_request.dart';
import 'package:rafiq/features/auth/data/models/patient_sign_up_request.dart';
import 'package:rafiq/features/auth/data/models/user_response.dart';
import 'package:rafiq/features/auth/data/models/user_sign_up_body.dart';
import 'package:rafiq/features/auth/data/models/user_verification_request.dart';
import 'package:rafiq/features/auth/data/networking/auth_service.dart';
import 'package:rafiq/features/auth/data/repository/auth_repository.dart';
part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthService authService;
  final AuthRepository authRepository;
  AuthCubit(this.authService, this.authRepository) : super(AuthInitial());

  UserSignUpBody? userSignUpBody;
  late UserResponse userResponse;

  void doctorSignUp() {
    emit(AuthLoading());
    authService
        .registerDoctor(userSignUpBody as DoctorSignUpRequest)
        .then((_) {
          emit(AuthSuccess());
        })
        .catchError((e) {
          emit(AuthFailure(e.toString()));
        });
  }

  void patientSignUp() {
    emit(AuthLoading());
    authService
        .registerPatient(userSignUpBody as PatientSignUpRequest)
        .then((_) {
          emit(AuthSuccess());
        })
        .catchError((e) {
          emit(AuthFailure(e.toString()));
        });
  }

  void userVerification(UserVerificationRequest body) {
    emit(AuthLoading());
    authRepository
        .userVerificationRepository(body)
        .then((value) {
          userResponse = value;
          emit(AuthSuccess());
        })
        .catchError((e) {
          emit(AuthFailure(e.toString()));
        });
  }

  void logIn(LoginRequest body) {
    emit(AuthLoading());
    authRepository
        .logInRepository(body)
        .then((value) {
          userResponse = value;
          emit(AuthSuccess());
        })
        .catchError((e) {
          emit(AuthFailure(e.toString()));
        });
  }

  static AuthCubit get(context) => BlocProvider.of(context);
}
