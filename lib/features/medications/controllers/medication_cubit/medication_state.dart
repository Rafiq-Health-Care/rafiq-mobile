part of 'medication_cubit.dart';

@immutable
sealed class MedicationState extends Equatable {}

final class MedicationInitial extends MedicationState {
  @override
  List<Object?> get props => [];
}

final class MedicationLoading extends MedicationState {
  final bool isFirstFetch;
  MedicationLoading({this.isFirstFetch = false});

  @override
  List<Object?> get props => [isFirstFetch];
}

final class MedicationLoaded extends MedicationState {
  final List<AllMedicinesContentModel> medications;
  final bool hasReachedMax;
  final int total;
  final AllMedicinesRequest request;

  MedicationLoaded({
    required this.medications,
    this.hasReachedMax = false,
    required this.request,
    required this.total,
  });

  MedicationLoaded copyWith({
    List<AllMedicinesContentModel>? medications,
    bool? hasReachedMax,
    AllMedicinesRequest? request,
    int? total,
  }) {
    return MedicationLoaded(
      medications: medications ?? this.medications,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      request: request ?? this.request,
      total: total ?? this.total,
    );
  }

  @override
  List<Object?> get props => [medications, hasReachedMax, request];
}

final class MedicationAdded extends MedicationState {
  final AllMedicinesContentModel newMedicine;

  MedicationAdded({required this.newMedicine});
  @override
  List<Object?> get props => [newMedicine];
}

final class MedicationError extends MedicationState {
  final String message;
  final List<AllMedicinesContentModel>? medications;
  MedicationError({required this.message, this.medications});

  @override
  List<Object?> get props => [message, medications];
}
