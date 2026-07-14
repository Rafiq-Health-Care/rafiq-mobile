import 'package:equatable/equatable.dart';
import 'package:rafiq/features/Consultation/domain/enum/consultation_status_enum.dart';

class PatientConsultationParams extends Equatable {
  final ConsultationStatusEnum status;
  final int page;
  final int size;

  const PatientConsultationParams({
    required this.status,
    this.page = 0,
    this.size = 20,
  });

  PatientConsultationParams copyWith({
    ConsultationStatusEnum? status,
    int? page,
    int? size,
  }) {
    return PatientConsultationParams(
      status: status ?? this.status,
      page: page ?? this.page,
      size: size ?? this.size,
    );
  }

  @override
  List<Object> get props => [status, page, size];
}