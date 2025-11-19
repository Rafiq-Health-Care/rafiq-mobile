class ContentModel {
  final String name;
  final String testId;
  final String fileUrl;
  final String fileType;

  const ContentModel({
    required this.name,
    required this.testId,
    required this.fileUrl,
    required this.fileType,
  });

  factory ContentModel.fromJson(Map<String, dynamic> json) {
    return ContentModel(
      name: json['name'] as String,
      testId: json['testId'] as String,
      fileUrl: json['fileUrl'] as String,
      fileType: json['fileType'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'testId': testId,
      'fileUrl': fileUrl,
      'fileType': fileType,
    };
  }
}
