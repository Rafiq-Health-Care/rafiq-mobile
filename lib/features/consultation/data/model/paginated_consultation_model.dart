import 'package:rafiq/features/consultation/data/model/consultation_model.dart';
import 'package:rafiq/features/consultation/domain/entity/consultation_entity.dart';
import 'package:rafiq/features/consultation/domain/entity/paginated_consultation_entity.dart';

class PaginatedConsultationModel {
  final List<ConsultationEntity> consultations;
  final bool isLastPage;
  final int totalPages;

  PaginatedConsultationModel({
    required this.consultations,
    required this.isLastPage,
    required this.totalPages,
  });

  factory PaginatedConsultationModel.fromJson(Map<String, dynamic> json) {
    return PaginatedConsultationModel(
      consultations: (json['content'] as List)
          .map((e) => ConsultationModel.fromJson(e).toEntity())
          .toList(),
      isLastPage: json['lastPage'],
      totalPages: json['totalPages'],
    );
  }

  PaginatedConsultationEntity toEntity() {
    return PaginatedConsultationEntity(
      consultations: consultations,
      isLastPage: isLastPage,
      totalPages: totalPages,
    );
  }
}
