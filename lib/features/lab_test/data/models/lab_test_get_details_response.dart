import 'package:rafiq/features/lab_test/data/models/test_model.dart';

class LabTestGetDetailsResponse {
  final String name;
  final String testId;
  final String fileUrl;
  final String fileType;
  final DateTime date;
  final List<TestModel> tests;

  const LabTestGetDetailsResponse({
    required this.name,
    required this.testId,
    required this.fileUrl,
    required this.fileType,
    required this.date,
    required this.tests,
  });

  factory LabTestGetDetailsResponse.fromJson(Map<String, dynamic> json) {
    return LabTestGetDetailsResponse(
      name: json['name'] as String,
      testId: json['testId'] as String,
      fileUrl: json['fileUrl'] as String,
      fileType: json['fileType'] as String,
      date: DateTime.parse(json['date']),
      tests: (json['tests'] as List)
          .map((e) => TestModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'testId': testId,
      'fileUrl': fileUrl,
      'fileType': fileType,
      'date': date.toIso8601String(),
      'tests': tests.map((e) => e.toJson()).toList(),
    };
  }
}
