import 'package:dartz/dartz.dart';
import 'package:rafiq/core/errors/failure.dart';
import '../entities/consultation.dart';

abstract class ConsultationDetailsRepository {
  Future<Either<Failure, Consultation>> getConsultationDetails({
    required String slotId,
  });

  Future<Either<Failure, void>> cancelConsultation({
    required String consultationId,
    String? reason,
  });
}
