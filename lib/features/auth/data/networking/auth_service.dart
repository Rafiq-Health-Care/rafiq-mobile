import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:rafiq/core/constants/secure.dart';
import 'package:rafiq/core/errors/failure.dart';
import 'package:rafiq/core/errors/server_failure.dart';
import 'package:rafiq/core/networking/api_constants.dart';
import 'package:rafiq/core/networking/api_service.dart';
import 'package:rafiq/features/auth/data/models/reset_password_request.dart';
import 'package:rafiq/features/auth/data/models/doctor_sign_up_request.dart';
import 'package:rafiq/features/auth/data/models/login_request.dart';
import 'package:rafiq/features/auth/data/models/patient_sign_up_request.dart';
import 'package:rafiq/features/auth/data/models/user_verification_request.dart';

class AuthService {
  final ApiService _api;
  AuthService({required ApiService api}) : _api = api;

  Future<Either<Failure, dynamic>> login(LoginRequest body) async {
    try {
      Response response = await _api.post(
        ApiConstants.login,
        data: body.toJson(),
      );
      return right(response.data);
    } catch (e) {
      return left(e as Failure);
    }
  }

  Future<Either<Failure, void>> registerPatient(
    PatientSignUpRequest body,
  ) async {
    try {
      await _api.post(ApiConstants.registerPatient, data: body.toJson());
      return right(null);
    } catch (e) {
      return left(e as Failure);
    }
  }

  Future<Either<Failure, void>> registerDoctor(DoctorSignUpRequest body) async {
    final formData = await body.toFormData();

    try {
      await _api.post(
        ApiConstants.registerDoctor,
        data: formData,
        options: Options(headers: {'Content-Type': 'multipart/form-data'}),
      );
      return right(null);
    } catch (e) {
      return left(e as Failure);
    }
  }

  Future<Either<Failure, dynamic>> userVerification(
    UserVerificationRequest body,
  ) async {
    try {
      Response response = await _api.post(
        ApiConstants.userVerification,
        data: body.toJson(),
      );
      return right(response.data);
    } catch (e) {
      return left(e as Failure);
    }
  }

  Future<Either<Failure, void>> sendNewOtp(String email) async {
    try {
      await _api.post(ApiConstants.newOtp, data: {'email': email});
      return right(null);
    } catch (e) {
      return left(e as Failure);
    }
  }

  Future<Either<Failure, List<dynamic>>> getSpecialization() async {
    try {
      Response response = await _api.get(ApiConstants.specialization);
      return right(response.data);
    } catch (e) {
      return left(e as Failure);
    }
  }

  Future<Either<Failure, void>> authWithGoogle() async {
    try {
      final idToken = await _googleSignIn();
      await _api.post(ApiConstants.authWithGoogle, data: {'idToken': idToken});
      return right(null);
    } catch (e) {
      return left(e as Failure);
    }
  }

  Future<String> _googleSignIn() async {
    try {
      await GoogleSignIn.instance.initialize(serverClientId: serverClientId);

      final GoogleSignInAccount account = await GoogleSignIn.instance
          .authenticate();

      final String? idToken = account.authentication.idToken;

      if (idToken == null) {
        throw ServerFailure('ID token missing from Google response.');
      }

      return idToken;
    } catch (e) {
      rethrow;
    }
  }

  Future<Either<Failure, void>> forgetPassword(String email) async {
    try {
      await _api.post(ApiConstants.forgetPassword, data: {'email': email});
      return right(null);
    } catch (e) {
      return left(e as Failure);
    }
  }

  Future<Either<Failure, void>> resetPassword(ResetPasswordRequest body) async {
    try {
      await _api.post(ApiConstants.resetPassword, data: body.toJson());
      return right(null);
    } catch (e) {
      return left(e as Failure);
    }
  }

  Future<Either<Failure, void>> logout() async {
    try {
      await _api.post(ApiConstants.authLogout);
      await _api.clearCookies();
      return right(null);
    } catch (e) {
      return left(e as Failure);
    }
  }
}
