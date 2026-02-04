import 'package:dio/dio.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:rafiq/core/constants/secure.dart';
import 'package:rafiq/core/networking/api_constants.dart';
import 'package:rafiq/core/networking/api_service.dart';
import 'package:rafiq/features/auth/data/models/reset_password_request.dart';
import 'package:rafiq/features/auth/data/models/doctor_sign_up_request.dart';
import 'package:rafiq/features/auth/data/models/login_request.dart';
import 'package:rafiq/features/auth/data/models/patient_sign_up_request.dart';
import 'package:rafiq/features/auth/data/models/user_verification_request.dart';

class AuthService {
  final _api = ApiService.instance;

  Future<dynamic> login(LoginRequest body) async {
    try {
      Response response = await _api.post(
        ApiConstants.login,
        data: body.toJson(),
      );
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> registerPatient(PatientSignUpRequest body) async {
    try {
      await _api.post(ApiConstants.registerPatient, data: body.toJson());
    } catch (e) {
      rethrow;
    }
  }

  Future<void> registerDoctor(DoctorSignUpRequest body) async {
    final formData = await body.toFormData();

    try {
      await _api.post(
        ApiConstants.registerDoctor,
        data: formData,
        options: Options(headers: {'Content-Type': 'multipart/form-data'}),
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> userVerification(UserVerificationRequest body) async {
    try {
      Response response = await _api.post(
        ApiConstants.userVerification,
        data: body.toJson(),
      );
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> sendNewOtp(String email) async {
    try {
      await _api.post(ApiConstants.newOtp, data: {'email': email});
    } catch (e) {
      rethrow;
    }
  }

  Future<List<dynamic>> getSpecialization() async {
    try {
      Response response = await _api.get(ApiConstants.specialization);
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> authWithGoogle() async {
    try {
      final idToken = await _googleSignIn();
      await _api.post(ApiConstants.authWithGoogle, data: {'idToken': idToken});
    } catch (e) {
      rethrow;
    }
  }

  Future<String> _googleSignIn() async {
    try {
      await GoogleSignIn.instance.initialize(serverClientId: serverClientId);

      final GoogleSignInAccount account = await GoogleSignIn.instance
          .authenticate();

      final String? idToken = account.authentication.idToken;

      if (idToken == null) {
        throw Exception('ID token missing from Google response.');
      }

      return idToken;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> forgetPassword(String email) async {
    try {
      await _api.post(ApiConstants.forgetPassword, data: {'email': email});
    } catch (e) {
      rethrow;
    }
  }

  Future<void> resetPassword(ResetPasswordRequest body) async {
    try {
      await _api.post(ApiConstants.resetPassword, data: body.toJson());
    } catch (e) {
      rethrow;
    }
  }
}
