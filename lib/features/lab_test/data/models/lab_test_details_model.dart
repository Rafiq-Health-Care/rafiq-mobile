import 'package:rafiq/features/lab_test/data/models/test_model.dart';

class LabTestDetailsModel {
  final String name;
  final String testId;
  final String fileId;
  final DateTime date;
  final List<TestModel> tests;

  const LabTestDetailsModel({
    required this.name,
    required this.testId,
    required this.fileId,
    required this.date,
    required this.tests,
  });

  factory LabTestDetailsModel.fromJson(Map<String, dynamic> json) {
    return LabTestDetailsModel(
      name: json['name'] as String,
      testId: json['testId'] as String,
      fileId: json['fileId'] as String,
      date: DateTime.parse(json['date']),
      tests: json['tests'] == null
          ? []
          : (json['tests'] as List)
                .map((e) => TestModel.fromJson(e as Map<String, dynamic>))
                .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'testId': testId,
      'fileId': fileId,
      'date': date.toIso8601String(),
      'tests': tests.map((e) => e.toJson()).toList(),
    };
  }
}
