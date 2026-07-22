import 'package:rafiq/core/networking/api_constants.dart';
import 'package:rafiq/core/networking/api_service.dart';
import 'package:rafiq/features/consultation/data/model/consultation_details_model.dart';
import 'package:rafiq/features/consultation/data/model/doctor_consultation_model.dart';
import 'package:rafiq/features/consultation/data/model/paginated_consultation_model.dart';

abstract class ConsultationRemoteDataSource {
  Future<PaginatedConsultationModel> patientConsultations({
    required int page,
    required int size,
    required String status,
  });

  Future<ConsultationDetailsModel> patientConsultationDetails({
    required String id,
  });

  Future<DoctorConsultationModel> doctorConsultationDetails(String slotId);

  Future<void> cancelConsultation(String consultationId, String? reason);
}

class ConsultationRemoteDataSourceImpl implements ConsultationRemoteDataSource {
  final ApiService apiService;
  ConsultationRemoteDataSourceImpl(this.apiService);

  @override
  Future<PaginatedConsultationModel> patientConsultations({
    required int page,
    required int size,
    required String status,
  }) async {
    final response = await apiService.get(
      '${ApiConstants.patientConsultations}/$status',
      queryParameters: {'page': page, 'size': size},
    );
    return PaginatedConsultationModel.fromJson(response.data);
  }

  @override
  Future<ConsultationDetailsModel> patientConsultationDetails({
    required String id,
  }) async {
    final response = await apiService.get('${ApiConstants.consultation}/$id');
    return ConsultationDetailsModel.fromJson(response.data);
  }

  @override
  Future<DoctorConsultationModel> doctorConsultationDetails(
    String slotId,
  ) async {
    final response = await apiService.get('${ApiConstants.slot}/$slotId');
    return DoctorConsultationModel.fromJson(response.data);
  }

  @override
  Future<void> cancelConsultation(String consultationId, String? reason) async {
    await apiService.patch(
      ApiConstants.cancelConsultation(consultationId),
      data: {'reason': reason},
    );
  }
}
