class LabTestFileResponse {
  final String fileName;
  final String fileType;
  final int size;
  final String fileUrl;

  LabTestFileResponse({
    required this.fileName,
    required this.fileType,
    required this.size,
    required this.fileUrl,
  });

  factory LabTestFileResponse.fromJson(Map<String, dynamic> json) {
    return LabTestFileResponse(
      fileName: json['fileName'] as String,
      fileType: json['fileType'] as String,
      size: json['size'] as int,
      fileUrl: json['fileUrl'] as String,
    );
  }
}
