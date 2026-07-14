import 'package:rafiq/core/networking/api_constants.dart';
import 'package:rafiq/core/networking/api_service.dart';
import 'package:rafiq/features/Consultation/data/data_source/remote_data_source.dart';
import 'package:rafiq/features/Consultation/data/model/consultation_details_model.dart';
import 'package:rafiq/features/Consultation/data/model/doctor_details_model.dart';
import 'package:rafiq/features/Consultation/data/model/paginated_doctors_model.dart';
import 'package:rafiq/features/Consultation/data/model/paginated_consultation_model.dart';
import 'package:rafiq/features/Consultation/data/model/payment_model.dart';
import 'package:rafiq/features/Consultation/data/model/slot_pagination_model.dart';

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

  @override
  Future<PaymentModel> reserveConsultationSlot({
    required Map<String, dynamic> reserveConsultationSlotBody,
  }) async {
    final response = await apiService.post(
      ApiConstants.consultation,
      data: reserveConsultationSlotBody,
    );
    return PaymentModel.fromJson(response.data);
  }

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
  Future<ConsultationDetailsModel> consultationDetails({required String id}) async{
    final response = await apiService.get('${ApiConstants.consultation}/$id');
    return ConsultationDetailsModel.fromJson(response.data);
  }
}
