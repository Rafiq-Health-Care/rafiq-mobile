import 'dart:io';
import 'package:dio/dio.dart';

class LabTestUploadRequest {
  final File file;

  const LabTestUploadRequest({required this.file});

  Future<FormData> toFormData() async {
    return FormData.fromMap({
      'file': await MultipartFile.fromFile(
        file.path,
        filename: file.uri.pathSegments.last,
        contentType: DioMediaType('multipart', 'form-data'),
      ),
    });
  }
}
