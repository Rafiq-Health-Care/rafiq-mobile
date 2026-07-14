import 'package:rafiq/core/networking/api_constants.dart';
import 'package:rafiq/core/networking/api_service.dart';
import 'package:rafiq/features/consultation_details/data/models/consultation_model.dart';

abstract class ConsultationRemoteDataSource {
  Future<ConsultationModel> getConsultationDetails(String slotId);
  Future<void> cancelConsultation(String consultationId, String? reason);
}

class ConsultationRemoteDataSourceImpl implements ConsultationRemoteDataSource {
  final ApiService apiService;

  ConsultationRemoteDataSourceImpl(this.apiService);

  @override
  Future<ConsultationModel> getConsultationDetails(String slotId) async {
    final response = await apiService.get('${ApiConstants.slot}/$slotId');
    final data = response.data;
    return ConsultationModel.fromJson(data);
  }

  @override
  Future<void> cancelConsultation(String consultationId, String? reason) async {
    await apiService.patch(
      ApiConstants.cancelConsultation(consultationId),
      data: {'reason': reason},
    );
  }
}
