import 'package:rafiq/features/auth/data/models/user_sign_up_body.dart';

class PatientSignUpRequest extends UserSignUpBody {
  PatientSignUpRequest({
    super.email,
    super.password,
    super.firstName,
    super.lastName,
    super.phone,
    super.age,
    super.gender,
  });
}
