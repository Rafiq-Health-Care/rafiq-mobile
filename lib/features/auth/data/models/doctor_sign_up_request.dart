import 'package:rafiq/features/auth/data/models/user_sign_up_body.dart';

class DoctorSignUpRequest extends UserSignUpBody {
  String? specialization;
  String? description;
  String? nationalId;

  DoctorSignUpRequest({
    super.email,
    super.password,
    super.firstName,
    super.lastName,
    super.phone,
    super.age,
    super.gender,
    this.specialization,
    this.description,
    this.nationalId,
  });

  @override
  Map<String, dynamic> toJson() {
    return {
      ...super.toJson(),
      'specialization': specialization,
      'description': description,
      'nationalId': nationalId,
    };
  }
}
