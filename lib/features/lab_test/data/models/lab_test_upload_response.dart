import 'package:rafiq/features/lab_test/data/models/test_model.dart';

class LabTestUploadResponse {
  List<TestModel> tests;
  String testId;

  LabTestUploadResponse({required this.tests, required this.testId});
  
  factory LabTestUploadResponse.fromJson(Map<String, dynamic> json) {
    return LabTestUploadResponse(
      tests: (json['tests'] as List)
          .map((e) => TestModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      testId: json['testId'] as String,
    );
  }
}
