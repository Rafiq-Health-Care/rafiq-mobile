import 'package:equatable/equatable.dart';
import 'package:rafiq/features/Consultation/domain/entity/doctor_details_entity.dart';

sealed class DoctorDetailsState extends Equatable {
  const DoctorDetailsState();

  @override
  List<Object?> get props => [];
}

final class DoctorDetailsInitial extends DoctorDetailsState {}

final class DoctorDetailsLoading extends DoctorDetailsState {}

final class DoctorDetailsSuccess extends DoctorDetailsState {
  final DoctorDetailsEntity details;

  const DoctorDetailsSuccess({required this.details});

  @override
  List<Object?> get props => [details];
}

final class DoctorDetailsFailure extends DoctorDetailsState {
  final String message;

  const DoctorDetailsFailure({required this.message});

  @override
  List<Object?> get props => [message];
}
