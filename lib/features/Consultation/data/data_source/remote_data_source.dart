import 'package:rafiq/core/networking/api_constants.dart';
import 'package:rafiq/core/networking/api_service.dart';
import 'package:rafiq/features/Consultation/data/model/doctor_details_model.dart';
import 'package:rafiq/features/Consultation/data/model/paginated_doctors_model.dart';
import 'package:rafiq/features/Consultation/data/model/slot_pagination_model.dart';

abstract class RemoteDataSource {
  Future<PaginatedDoctorsModel> searchDoctors({
    required int page,
    required int size,
    required Map<String, dynamic> filterBody,
  });

  Future<DoctorDetailsModel> getDoctorDetails({required String id});
  Future<SlotPaginationModel> patientSeeDoctorsSlots({
    required String doctorId,
    required int page,
    required int size,
  });
}

class RemoteDataSourceImpl implements RemoteDataSource {
  final ApiService apiService;
  RemoteDataSourceImpl(this.apiService);

  @override
  Future<PaginatedDoctorsModel> searchDoctors({
    required int page,
    required int size,
    required Map<String, dynamic> filterBody,
  }) async {
    final response = await apiService.post(
      ApiConstants.doctorSearch,
      queryParameters: {'page': page, 'size': size},
      data: filterBody,
    );
    return PaginatedDoctorsModel.fromJson(response.data);
  }

  @override
  Future<DoctorDetailsModel> getDoctorDetails({required String id}) async {
    final response = await apiService.get('${ApiConstants.doctor}/$id');
    return DoctorDetailsModel.fromJson(response.data);
  }

  @override
  Future<SlotPaginationModel> patientSeeDoctorsSlots({
    required String doctorId,
    required int page,
    required int size,
  }) async {
    final response = await apiService.get(
      '${ApiConstants.patientSeeDoctorsSlots}/$doctorId',
      queryParameters: {'page': page, 'size': size},
    );
    return SlotPaginationModel.fromJson(response.data);
  }
}
