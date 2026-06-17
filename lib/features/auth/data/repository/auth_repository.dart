import 'package:dartz/dartz.dart';
import 'package:rafiq/core/errors/failure.dart';
import 'package:rafiq/features/auth/data/models/doctor_sign_up_request.dart';
import 'package:rafiq/features/auth/data/models/login_request.dart';
import 'package:rafiq/features/auth/data/models/patient_sign_up_request.dart';
import 'package:rafiq/features/auth/data/models/reset_password_request.dart';
import 'package:rafiq/features/auth/data/models/user_response.dart';
import 'package:rafiq/features/auth/data/models/user_verification_request.dart';
import 'package:rafiq/features/auth/data/networking/auth_service.dart';

class AuthRepository {
  final AuthService authService;
  AuthRepository({required this.authService});

  Future<Either<Failure, UserResponse>> logInRepository(
    LoginRequest body,
  ) async {
    final rowData = await authService.login(body);
    return rowData.fold(
      (failure) => left(failure),
      (rowData) => right(UserResponse.fromJson(rowData)),
    );
  }

  Future<Either<Failure, void>> doctorSignUpRepository(
    DoctorSignUpRequest body,
  ) async {
    final rowData = await authService.registerDoctor(body);
    return rowData.fold(
      (failure) => left(failure),
      (rowData) => right(rowData),
    );
  }

  Future<Either<Failure, void>> patientSignUpRepository(
    PatientSignUpRequest body,
  ) async {
    final rowData = await authService.registerPatient(body);
    return rowData.fold(
      (failure) => left(failure),
      (rowData) => right(rowData),
    );
  }

  Future<Either<Failure, void>> authWithGoogleRepository() async {
    final rowData = await authService.authWithGoogle();
    return rowData.fold(
      (failure) => left(failure),
      (rowData) => right(rowData),
    );
  }

  Future<Either<Failure, UserResponse>> userVerificationRepository(
    UserVerificationRequest body,
  ) async {
    final rowData = await authService.userVerification(body);
    return rowData.fold(
      (failure) => left(failure),
      (rowData) => right(UserResponse.fromJson(rowData)),
    );
  }

  Future<Either<Failure, List<String>>>
  getSpecializationsRepository() async {
    final rowData = await authService.getSpecialization();
    return rowData.fold(
      (failure) => left(failure),
      (rowData) => right(rowData.map((e) => e as String).toList()),
    );
  }

  Future<Either<Failure, void>> sendNewOtpRepository(String email) async {
    final rowData = await authService.sendNewOtp(email);
    return rowData.fold(
      (failure) => left(failure),
      (rowData) => right(rowData),
    );
  }

  Future<Either<Failure, void>> forgetPasswordRepository(String email) async {
    final rowData = await authService.forgetPassword(email);
    return rowData.fold(
      (failure) => left(failure),
      (rowData) => right(rowData),
    );
  }

  Future<Either<Failure, void>> resetPasswordRepository(
    ResetPasswordRequest body,
  ) async {
    final rowData = await authService.resetPassword(body);
    return rowData.fold(
      (failure) => left(failure),
      (rowData) => right(rowData),
    );
  }

  Future<Either<Failure, void>> logoutRepository() async {
    final rowData = await authService.logout();
    return rowData.fold(
      (failure) => left(failure),
      (rowData) => right(rowData),
    );
  }
}
