part of 'medication_details_cubit.dart';

@immutable
sealed class MedicationDetailsState extends Equatable {
  @override
  List<Object?> get props => [];
}

final class MedicationDetailsInitial extends MedicationDetailsState {}

final class MedicationDetailsLoading extends MedicationDetailsState {}

final class MedicationDetailsLoaded extends MedicationDetailsState {
  final MedicinesDetailsModel medicationDetails;
  MedicationDetailsLoaded(this.medicationDetails);

  @override
  List<Object?> get props => [medicationDetails];
}

final class MedicationDetailsError extends MedicationDetailsState {
  final String message;
  MedicationDetailsError(this.message);

  @override
  List<Object?> get props => [message];
}
