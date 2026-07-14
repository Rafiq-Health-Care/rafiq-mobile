class ContentModel {
  final String name;
  final String testId;
  final String fileUrl;

  const ContentModel({
    required this.name,
    required this.testId,
    required this.fileUrl,
  });

  factory ContentModel.fromJson(Map<String, dynamic> json) {
    return ContentModel(
      name: json['name'] as String,
      testId: json['testId'] as String,
      fileUrl: json['fileUrl'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'testId': testId, 'fileId': fileUrl};
  }
}
