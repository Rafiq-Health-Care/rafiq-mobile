import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:rafiq/core/errors/failure.dart';
import '../entities/consultation.dart';
import '../repositories/consultation_repository.dart';

class GetConsultationDetails {
  final ConsultationDetailsRepository repository;
  GetConsultationDetails(this.repository);

  Future<Either<Failure, Consultation>> call(
    GetConsultationDetailsParams params,
  ) {
    return repository.getConsultationDetails(slotId: params.slotId);
  }
}

class GetConsultationDetailsParams extends Equatable {
  final String slotId;

  const GetConsultationDetailsParams({required this.slotId});

  @override
  List<Object?> get props => [slotId];
}
