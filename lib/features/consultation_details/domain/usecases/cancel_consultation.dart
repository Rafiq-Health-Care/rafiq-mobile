import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:rafiq/core/errors/failure.dart';
import '../repositories/consultation_repository.dart';

class CancelConsultation {
  final ConsultationDetailsRepository repository;
  CancelConsultation(this.repository);

  Future<Either<Failure, void>> call(CancelConsultationParams params) {
    return repository.cancelConsultation(
      consultationId: params.consultationId,
      reason: params.reason,
    );
  }
}

class CancelConsultationParams extends Equatable {
  final String consultationId;
  final String? reason;

  const CancelConsultationParams({required this.consultationId, this.reason});

  @override
  List<Object?> get props => [consultationId, reason];
}
