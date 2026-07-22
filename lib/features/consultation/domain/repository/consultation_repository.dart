import 'package:dartz/dartz.dart';
import 'package:rafiq/core/errors/failure.dart';
import 'package:rafiq/features/consultation/domain/entity/consultation_details_entity.dart';
import 'package:rafiq/features/consultation/domain/entity/doctor_consultation_entity.dart';
import 'package:rafiq/features/consultation/domain/entity/paginated_consultation_entity.dart';
import 'package:rafiq/features/consultation/domain/params/patient_consultation_params.dart';

/// The consultation as a shared resource, viewed from both roles:
/// - patient methods: [patientConsultations], [patientConsultationDetails]
/// - doctor methods: [doctorConsultationDetails], [cancelConsultation]
abstract class ConsultationRepository {
  Future<Either<Failure, PaginatedConsultationEntity>> patientConsultations({
    required PatientConsultationParams params,
  });

  Future<Either<Failure, ConsultationDetailsEntity>> patientConsultationDetails({
    required String id,
  });

  Future<Either<Failure, DoctorConsultationEntity>> doctorConsultationDetails({
    required String slotId,
  });

  Future<Either<Failure, void>> cancelConsultation({
    required String consultationId,
    String? reason,
  });
}
