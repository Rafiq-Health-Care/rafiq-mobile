import 'package:dartz/dartz.dart';
import 'package:rafiq/core/errors/failure.dart';
import 'package:rafiq/features/doctor_discovery/domain/entity/doctor_details_entity.dart';
import 'package:rafiq/features/doctor_discovery/domain/entity/paginated_doctors_entity.dart';
import 'package:rafiq/features/doctor_discovery/domain/entity/payment_entity.dart';
import 'package:rafiq/features/doctor_discovery/domain/entity/slot_pagination_entity.dart';

/// Covers the patient's "find a doctor and book a slot" workflow. Once a
/// slot is reserved, everything about that booking going forward lives in
/// the `consultation` feature instead.
abstract class DoctorDiscoveryRepository {
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
