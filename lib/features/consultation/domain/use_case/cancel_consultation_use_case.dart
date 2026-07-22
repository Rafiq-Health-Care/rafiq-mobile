import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:rafiq/core/errors/failure.dart';
import 'package:rafiq/features/consultation/domain/repository/consultation_repository.dart';

class CancelConsultationUseCase {
  final ConsultationRepository repository;
  CancelConsultationUseCase(this.repository);

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
