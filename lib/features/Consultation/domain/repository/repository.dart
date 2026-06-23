import 'package:dartz/dartz.dart';
import 'package:rafiq/core/errors/failure.dart';
import 'package:rafiq/features/Consultation/domain/entity/doctor_details_entity.dart';
import 'package:rafiq/features/Consultation/domain/entity/paginated_doctors_entity.dart';
import 'package:rafiq/features/Consultation/domain/entity/payment_entity.dart';
import 'package:rafiq/features/Consultation/domain/entity/slot_pagination_entity.dart';

abstract class Repository {
  Future<Either<Failure, PaginatedDoctorsEntity>> searchDoctors({
    required int page,
    required int size,
    required Map<String, dynamic> filterBody,
  });

  Future<Either<Failure, DoctorDetailsEntity>> getDoctorDetails({
    required String id,
  });

  Future<Either<Failure, SlotPaginationEntity>> patientSeeDoctorsSlots({
    required String doctorId,
    required int page,
    required int size,
  });

  Future<Either<Failure, PaymentEntity>> reserveConsultationSlot({
    required Map<String, dynamic> reserveConsultationSlotBody,
  });
}
