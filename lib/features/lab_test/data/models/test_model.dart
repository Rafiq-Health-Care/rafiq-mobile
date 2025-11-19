class TestModel {
  final String testName;
  final String result;
  final String unit;
  final String status;

  const TestModel({
    required this.testName,
    required this.result,
    required this.unit,
    required this.status,
  });

  factory TestModel.fromJson(Map<String, dynamic> json) {
    return TestModel(
      testName: json['testName'] as String,
      result: json['result'] as String,
      unit: json['unit'] as String,
      status: json['status'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'testName': testName,
      'result': result,
      'unit': unit,
      'status': status,
    };
  }
}
