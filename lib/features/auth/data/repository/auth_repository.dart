import 'package:rafiq/features/auth/data/models/login_request.dart';
import 'package:rafiq/features/auth/data/models/specialization_model.dart';
import 'package:rafiq/features/auth/data/models/user_response.dart';
import 'package:rafiq/features/auth/data/models/user_verification_request.dart';
import 'package:rafiq/features/auth/data/networking/auth_service.dart';

class AuthRepository {
  final AuthService authService;

  AuthRepository({required this.authService});

  Future<UserResponse> logInRepository(LoginRequest body) async {
    final rawDate = await authService.login(body);
    return UserResponse.fromJson(rawDate);
  }

  Future<UserResponse> userVerificationRepository(
    UserVerificationRequest body,
  ) async {
    final rawDate = await authService.userVerification(body);
    return UserResponse.fromJson(rawDate);
  }

  Future<List<SpecializationModel>> getSpecializationsRepository() async {
    final rawDate = await authService.getSpecialization();
    return rawDate
        .map((e) => SpecializationModel.fromJson(e))
        .toList();
  }
}
