import 'package:rafiq/features/doctor_discovery/domain/entity/doctor_entity.dart';

class PaginatedDoctorsEntity {
  final List<DoctorEntity> doctors;
  final bool isLastPage;
  final int totalPages;

  PaginatedDoctorsEntity({
    required this.doctors,
    required this.isLastPage,
    required this.totalPages,
  });
}
