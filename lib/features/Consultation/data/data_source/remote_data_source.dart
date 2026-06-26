import 'package:rafiq/features/Consultation/data/model/doctor_details_model.dart';
import 'package:rafiq/features/Consultation/data/model/paginated_consultation_model.dart';
import 'package:rafiq/features/Consultation/data/model/paginated_doctors_model.dart';
import 'package:rafiq/features/Consultation/data/model/payment_model.dart';
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
  Future<PaymentModel> reserveConsultationSlot({
    required Map<String, dynamic> reserveConsultationSlotBody,
  });
  Future<PaginatedConsultationModel> patientConsultations({
    required int page,
    required int size,
    required String status,
  });
}
