import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rafiq/features/auth/data/models/doctor_sign_up_request.dart';
import 'package:rafiq/features/auth/data/models/login_request.dart';
import 'package:rafiq/features/auth/data/models/patient_sign_up_request.dart';
import 'package:rafiq/features/auth/data/models/user_response.dart';
import 'package:rafiq/features/auth/data/models/user_sign_up_body.dart';
import 'package:rafiq/features/auth/data/models/user_verification_request.dart';
import 'package:rafiq/features/auth/data/networking/repository/auth_repository.dart';
part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository authRepository;
  AuthCubit(this.authRepository) : super(AuthInitial());

  UserSignUpBody? userSignUpBody;
  late UserResponse userResponse;

  Future<void> doctorSignUp() async {
    emit(AuthLoading());
    final response = await authRepository.doctorSignUpRepository(
      userSignUpBody as DoctorSignUpRequest,
    );
    response.fold(
      (failure) => emit(AuthFailure(failure.message)),
      (success) => emit(DoctorSignUpSuccess(role: 'doctor')),
    );
  }

  Future<void> patientSignUp() async {
    emit(AuthLoading());
    final response = await authRepository.patientSignUpRepository(
      userSignUpBody as PatientSignUpRequest,
    );
    response.fold(
      (failure) => emit(AuthFailure(failure.message)),
      (success) => emit(PatientSignUpSuccess(role: 'patient')),
    );
  }

  Future<void> logIn(LoginRequest body) async {
    emit(AuthLoading());
    final response = await authRepository.logInRepository(body);
    response.fold((failure) => emit(AuthFailure(failure.message)), (
      userResponse,
    ) {
      this.userResponse = userResponse;
      emit(LogInSuccess(role: userResponse.roles));
    });
  }

  Future<void> authWithGoogle() async {
    emit(AuthLoading());
    final response = await authRepository.authWithGoogleRepository();
    response.fold(
      (failure) => emit(AuthFailure(failure.message)),
      (success) => emit(GoogleAuthSuccess()),
    );
  }

  Future<void> userVerification(String otp) async {
    emit(AuthLoading());
    final response = await authRepository.userVerificationRepository(
      UserVerificationRequest(email: userSignUpBody!.email!, otp: otp),
    );
    response.fold((failure) => emit(AuthFailure(failure.message)), (
      userResponse,
    ) {
      this.userResponse = userResponse;
      emit(UserVerificationSuccess());
    });
  }

  Future<void> sendNewOtp() async {
    emit(AuthLoading());
    final response = await authRepository.sendNewOtpRepository(
      userSignUpBody!.email!,
    );
    response.fold(
      (failure) => emit(AuthFailure(failure.message)),
      (success) => emit(UserVerificationResendSuccess()),
    );
  }

  Future<void> logout() async {
    emit(AuthLoading());
    final response = await authRepository.logoutRepository();
    response.fold(
      (failure) => emit(AuthFailure(failure.message)),
      (success) => emit(LogoutSuccess()),
    );
  }

  static AuthCubit get(context) => BlocProvider.of(context);
}
