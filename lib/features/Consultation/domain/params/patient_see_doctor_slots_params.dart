import 'package:equatable/equatable.dart';

class PatientSeeDoctorSlotsParams extends Equatable {
  final String doctorId;
  final int page;
  final int size;

  const PatientSeeDoctorSlotsParams({
    required this.doctorId,
    this.page = 0,
    this.size = 20,
  });

  PatientSeeDoctorSlotsParams copyWith({int? page, int? size}) {
    return PatientSeeDoctorSlotsParams(
      doctorId: doctorId,
      page: page ?? this.page,
      size: size ?? this.size,
    );
  }

  @override
  List<Object> get props => [doctorId, page, size];
}
