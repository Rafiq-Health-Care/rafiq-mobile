import 'package:rafiq/features/medications/data/models/all_medicines_content_model.dart';

class AllMedicinesResponse {
  final List<AllMedicinesContentModel> content;
  final int numberOfElements;
  final int size;
  final int totalPages;
  final bool lastPage;
  final bool firstPage;

  const AllMedicinesResponse({
    required this.content,
    required this.numberOfElements,
    required this.size,
    required this.totalPages,
    required this.lastPage,
    required this.firstPage,
  });

  factory AllMedicinesResponse.fromJson(Map<String, dynamic> json) {
    return AllMedicinesResponse(
      content: (json['content'] as List<dynamic>)
          .map((e) => AllMedicinesContentModel.fromJson(e))
          .toList(),
      numberOfElements: json['numberOfElements'] as int,
      size: json['size'] as int,
      totalPages: json['totalPages'] as int,
      lastPage: json['lastPage'] as bool,
      firstPage: json['firstPage'] as bool,
    );
  }
}
