import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rafiq/features/medications/data/enums/medicine_sort_enum.dart';
import 'package:rafiq/features/medications/data/enums/medicine_status_enum.dart';
import 'package:rafiq/features/medications/data/enums/medicine_type_enum.dart';
import 'package:rafiq/features/medications/data/models/all_medicines_content_model.dart';
import 'package:rafiq/features/medications/data/models/all_medicines_request.dart';
import 'package:rafiq/features/medications/data/models/medicines_bulk_request.dart';
import 'package:rafiq/features/medications/data/models/medicines_details_request.dart';
import 'package:rafiq/features/medications/data/repository/medication_repository.dart';

part 'medication_state.dart';

class MedicationCubit extends Cubit<MedicationState> {
  final MedicationRepository medicationRepository;
  MedicationCubit(this.medicationRepository) : super(MedicationInitial());

  Future<void> loadMedications(
    AllMedicinesRequest request, {
    bool needLoading = true,
  }) async {
    if (needLoading) {
      emit(MedicationLoading(isFirstFetch: true));
    }

    try {
      final allMedicineResponse = await medicationRepository.getAllMedicines(
        request,
      );
      emit(
        MedicationLoaded(
          medications: allMedicineResponse.content,
          hasReachedMax: allMedicineResponse.lastPage,
          request: request,
          total: allMedicineResponse.numberOfElements,
        ),
      );
    } catch (e) {
      emit(MedicationError(message: e.toString()));
    }
  }

  Future<void> loadMoreMedications() async {
    final currentState = state;
    if (currentState is! MedicationLoaded || currentState.hasReachedMax) {
      return;
    }

    try {
      final newResponse = await medicationRepository.getAllMedicines(
        currentState.request.copyWith(page: currentState.request.page + 1),
      );
      emit(
        MedicationLoaded(
          medications: {
            ...currentState.medications,
            ...newResponse.content,
          }.toList(),
          hasReachedMax: newResponse.lastPage,
          request: currentState.request.copyWith(
            page: currentState.request.page + 1,
          ),
          total: newResponse.numberOfElements,
        ),
      );
    } catch (e) {
      emit(
        MedicationError(
          message: e.toString(),
          medications: currentState.medications,
        ),
      );
    }
  }

  Future<void> addMedicine(MedicinesDetailsRequest medicineDetails) async {
    final currentState = state;
    if (currentState is! MedicationLoaded) return;

    try {
      final newMedicine = await medicationRepository.addMedicines(
        medicineDetails,
      );
      emit(
        MedicationLoaded(
          medications: {...currentState.medications, newMedicine}.toList(),
          hasReachedMax: currentState.hasReachedMax,
          request: currentState.request,
          total: currentState.total,
        ),
      );
    } catch (e) {
      emit(
        MedicationError(
          message: e.toString(),
          medications: currentState.medications,
        ),
      );

      // return previous state
      emit(currentState);
    }
  }

  Future<void> deleteMedicine(String id) async {
    final currentState = state;
    if (currentState is! MedicationLoaded) return;

    try {
      await medicationRepository.deleteMedicines(id);
      emit(
        MedicationLoaded(
          medications: currentState.medications
              .where((med) => med.id != id)
              .toList(),
          hasReachedMax: currentState.hasReachedMax,
          request: currentState.request.copyWith(
            page: currentState.request.page - 1,
          ),
          total: currentState.total,
        ),
      );
      // after deleting a medicine, we need to load more medications
      await loadMoreMedications();
    } catch (e) {
      emit(
        MedicationError(
          message: e.toString(),
          medications: currentState.medications,
        ),
      );

      // return previous state
      emit(currentState);
    }
  }

  Future<void> bulkMedicines(MedicinesBulkRequest request) async {
    final currentState = state;
    if (currentState is! MedicationLoaded) return;
    try {
      await medicationRepository.bulkMedicines(request);
      await loadMedications(currentState.request, needLoading: false);
    } catch (e) {
      emit(
        MedicationError(
          message: e.toString(),
          medications: currentState.medications,
        ),
      );
      // return previous state
      emit(currentState);
    }
  }

  Future<void> search(String query) async {
    final currentState = state;
    if (currentState is! MedicationLoaded) return;
    await loadMedications(
      currentState.request.copyWith(search: query, page: 0),
      needLoading: false,
    );
  }

  Future<void> filter(
    MedicineStatusEnum? status,
    MedicineTypeEnum? type,
    String? group,
  ) async {
    final currentState = state;
    if (currentState is! MedicationLoaded) return;
    await loadMedications(
      currentState.request.copyWith(
        status: status,
        type: type,
        groupId: group ?? '',
        page: 0,
      ),
      needLoading: false,
    );
  }

  Future<void> sort(MedicineSortEnum query) async {
    final currentState = state;
    if (currentState is! MedicationLoaded) return;
    await loadMedications(
      currentState.request.copyWith(sort: query, page: 0),
      needLoading: false,
    );
  }

  Future<void> refresh() async {
    final currentState = state;
    if (currentState is MedicationLoaded) {
      await loadMedications(currentState.request.copyWith(page: 0));
    } else {
      await loadMedications(AllMedicinesRequest());
    }
  }

  static MedicationCubit of(BuildContext context) {
    return context.read<MedicationCubit>();
  }
}
