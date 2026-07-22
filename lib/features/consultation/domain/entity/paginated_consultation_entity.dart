import 'package:rafiq/features/consultation/domain/entity/consultation_entity.dart';

class PaginatedConsultationEntity {
  final List<ConsultationEntity> consultations;
  final bool isLastPage;
  final int totalPages;

  PaginatedConsultationEntity({
    required this.consultations,
    required this.isLastPage,
    required this.totalPages,
  });
}
