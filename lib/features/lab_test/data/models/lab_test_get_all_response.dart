import 'package:rafiq/features/lab_test/data/models/content_model.dart';

class LabTestGetAllResponse {
  final List<ContentModel> content;
  final int numberOfElements;
  final int size;
  final int totalPages;
  final bool lastPage;
  final bool firstPage;

  const LabTestGetAllResponse({
    required this.content,
    required this.numberOfElements,
    required this.size,
    required this.totalPages,
    required this.lastPage,
    required this.firstPage,
  });

  factory LabTestGetAllResponse.fromJson(Map<String, dynamic> json) {
    return LabTestGetAllResponse(
      content: (json['content'] as List)
          .map((e) => ContentModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      numberOfElements: json['numberOfElements'] as int,
      size: json['size'] as int,
      totalPages: json['totalPages'] as int,
      lastPage: json['lastPage'] as bool,
      firstPage: json['firstPage'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'content': content.map((e) => e.toJson()).toList(),
      'numberOfElements': numberOfElements,
      'size': size,
      'totalPages': totalPages,
      'lastPage': lastPage,
      'firstPage': firstPage,
    };
  }
}
