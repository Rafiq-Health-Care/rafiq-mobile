import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rafiq/features/medications/data/models/medicines_details_model.dart';
import 'package:rafiq/features/medications/data/models/update_medicine_request.dart';
import 'package:rafiq/features/medications/data/repository/medication_repository.dart';

part 'medication_details_state.dart';

class MedicationDetailsCubit extends Cubit<MedicationDetailsState> {
  final MedicationRepository medicationRepository;
  MedicationDetailsCubit(this.medicationRepository)
    : super(MedicationDetailsInitial());

  Future<void> getMedicineDetails(String medicationId) async {
    emit(MedicationDetailsLoading());
    final medicationDetails = await medicationRepository.getMedicinesDetails(
      medicationId,
    );
    medicationDetails.fold(
      (failure) => emit(MedicationDetailsError(failure.message)),
      (medicationDetails) => emit(MedicationDetailsLoaded(medicationDetails)),
    );
  }

  Future<void> updateMedicineDetails(
    UpdateMedicineRequest medicationDetails,
  ) async {
    final currentState = state;
    if (currentState is! MedicationDetailsLoaded ||
        !_hasMedicationChange(
          currentState.medicationDetails,
          medicationDetails,
        )) {
      return;
    }

    final updatedDetails = await medicationRepository.updateMedicines(
      currentState.medicationDetails.id,
      medicationDetails,
    );
    updatedDetails.fold(
      (failure) => emit(MedicationDetailsError(failure.message)),
      (medicationDetails) => emit(MedicationDetailsLoaded(medicationDetails)),
    );
  }

  bool _hasMedicationChange(
    MedicinesDetailsModel oldMedicineDetails,
    UpdateMedicineRequest newMedicineDetails,
  ) {
    return oldMedicineDetails.name != newMedicineDetails.name ||
        oldMedicineDetails.notes != newMedicineDetails.notes ||
        oldMedicineDetails.frequency != newMedicineDetails.frequency ||
        oldMedicineDetails.startDate != newMedicineDetails.startDate ||
        oldMedicineDetails.endDate != newMedicineDetails.endDate ||
        oldMedicineDetails.type != newMedicineDetails.type ||
        oldMedicineDetails.status != newMedicineDetails.status ||
        oldMedicineDetails.dosage != newMedicineDetails.dosage ||
        oldMedicineDetails.reminderFrequency !=
            newMedicineDetails.reminderFrequency ||
        !listEquals(
          oldMedicineDetails.customDays,
          newMedicineDetails.customDays,
        );
  }

  static MedicationDetailsCubit of(BuildContext context) {
    return context.read<MedicationDetailsCubit>();
  }
}
