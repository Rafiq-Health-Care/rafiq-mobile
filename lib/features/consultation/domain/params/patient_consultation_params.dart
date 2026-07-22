import 'package:equatable/equatable.dart';
import 'package:rafiq/features/consultation/domain/enum/consultation_status.dart';

class PatientConsultationParams extends Equatable {
  final ConsultationStatus status;
  final int page;
  final int size;

  const PatientConsultationParams({
    required this.status,
    this.page = 0,
    this.size = 20,
  });

  PatientConsultationParams copyWith({
    ConsultationStatus? status,
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
