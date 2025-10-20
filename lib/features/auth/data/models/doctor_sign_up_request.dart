import 'package:rafiq/features/auth/data/models/user_sign_up_body.dart';

class DoctorSignUpRequest {
  final UserSignUpBody user;
  final String specialization;
  final String description;

  DoctorSignUpRequest({
    required this.user,
    required this.specialization,
    required this.description,
  });

  Map<String, dynamic> toJson() {
    return {
      'user': user.toJson(),
      'specialization': specialization,
      'description': description,
    };
  }
}