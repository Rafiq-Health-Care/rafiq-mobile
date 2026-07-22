import 'package:rafiq/features/doctor_discovery/data/model/doctor_model.dart';
import 'package:rafiq/features/doctor_discovery/domain/entity/paginated_doctors_entity.dart';

class PaginatedDoctorsModel {
  final List<DoctorModel> doctors;
  final bool isLastPage;
  final int totalPages;

  PaginatedDoctorsModel({
    required this.doctors,
    required this.isLastPage,
    required this.totalPages,
  });

  factory PaginatedDoctorsModel.fromJson(Map<String, dynamic> json) {
    var list = json['content'] as List? ?? [];
    List<DoctorModel> doctorList = list
        .map((i) => DoctorModel.fromJson(i))
        .toList();

    return PaginatedDoctorsModel(
      doctors: doctorList,
      isLastPage: json['lastPage'] ?? true,
      totalPages: json['totalPages'] ?? 0,
    );
  }

  PaginatedDoctorsEntity toEntity() {
    return PaginatedDoctorsEntity(
      doctors: doctors.map((e) => e.toEntity()).toList(),
      isLastPage: isLastPage,
      totalPages: totalPages,
    );
  }
}
