import 'test_model.dart';

class LabTestResultsModel {
  final String? name;
  final DateTime? date;
  final List<TestModel> tests;
  final String fileId;

  const LabTestResultsModel({
    this.name,
    this.date,
    required this.tests,
    required this.fileId,
  });

  factory LabTestResultsModel.fromJson(Map<String, dynamic> json) {
    return LabTestResultsModel(
      name: json['name'] as String,
      date: DateTime.parse(json['date']),
      tests: (json['tests'] as List)
          .map((e) => TestModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      fileId: json['fileId'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'date': date!.toIso8601String(),
      'tests': tests.map((e) => e.toJson()).toList(),
      'fileId': fileId,
    };
  }
}
