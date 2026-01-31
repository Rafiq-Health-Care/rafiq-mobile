import 'package:rafiq/features/groups/data/models/group_content_model.dart';

class AllGroupsResponse {
  final List<GroupContentModel> content;
  final int numberOfElements;
  final int size;
  final int totalPages;
  final bool lastPage;
  final bool firstPage;

  const AllGroupsResponse({
    required this.content,
    required this.numberOfElements,
    required this.size,
    required this.totalPages,
    required this.lastPage,
    required this.firstPage,
  });

  factory AllGroupsResponse.fromJson(Map<String, dynamic> json) {
    return AllGroupsResponse(
      content: (json['content'] as List<dynamic>)
          .map((e) => GroupContentModel.fromJson(e))
          .toList(),
      numberOfElements: json['numberOfElements'],
      size: json['size'],
      totalPages: json['totalPages'],
      lastPage: json['lastPage'],
      firstPage: json['firstPage'],
    );
  }
}
