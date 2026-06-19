import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:rafiq/features/auth/data/models/user_sign_up_body.dart';

class DoctorSignUpRequest extends UserSignUpBody {
  String? specialization;
  String? description;
  File? nationalId;

  DoctorSignUpRequest({
    super.email,
    super.password,
    super.firstName,
    super.lastName,
    super.phone,
    super.birthDate,
    super.gender,
    this.specialization,
    this.description,
    this.nationalId,
  });

  Future<FormData> toFormData() async {
    return FormData.fromMap({
      'doctorData': MultipartFile.fromString(
        jsonEncode({
          'user': super.toJson(),
          'specialization': specialization,
          'description': description,
        }),
        contentType: DioMediaType('application', 'json'),
      ),
      'nationalId': nationalId == null? null :await MultipartFile.fromFile(
        nationalId!.path,
        filename: nationalId!.uri.pathSegments.last,
        contentType: DioMediaType('multipart', 'form-data'),
      ),
    });
  }
}
