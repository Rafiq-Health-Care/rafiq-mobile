import 'package:rafiq/features/auth/data/models/user_sign_up_body.dart';

class PatientSignUpRequest extends UserSignUpBody {
  PatientSignUpRequest({
    required super.email,
    required super.password,
    required super.firstName,
    required super.lastName,
    required super.phone,
    required super.age,
    required super.gender,
  });
}