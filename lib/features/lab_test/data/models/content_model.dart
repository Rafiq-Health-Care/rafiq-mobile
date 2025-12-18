class ContentModel {
  final String name;
  final String testId;
  final String fileId;

  const ContentModel({
    required this.name,
    required this.testId,
    required this.fileId,
  });

  factory ContentModel.fromJson(Map<String, dynamic> json) {
    return ContentModel(
      name: json['name'] as String,
      testId: json['testId'] as String,
      fileId: json['fileId'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'testId': testId,
      'fileId': fileId,
    };
  }
}
