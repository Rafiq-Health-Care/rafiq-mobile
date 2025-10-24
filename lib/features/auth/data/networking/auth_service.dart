import 'package:dio/dio.dart';
import 'package:rafiq/core/networking/api_constants.dart';
import 'package:rafiq/core/networking/api_service.dart';
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

  Future<dynamic> registerPatient(PatientSignUpRequest body) async {
    try {
      Response response = await _api.post(
        ApiConstants.registerPatient,
        data: body.toJson(),
      );
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> registerDoctor(DoctorSignUpRequest body) async {
    final formData = await body.toFormData();

    try {
      Response response = await _api.post(
        ApiConstants.registerDoctor,
        data: formData,
        options: Options(headers: {'Content-Type': 'multipart/form-data'}),
      );

      return response.data;
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

  Future<List<dynamic>> getSpecialization() async {
    try {
      Response response = await _api.get(ApiConstants.specialization);
      return response.data;
    } catch (e) {
      rethrow;
    }
  }
}
