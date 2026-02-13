import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rafiq/features/medications/data/models/drug_model.dart';
import 'package:rafiq/features/medications/data/repository/medication_repository.dart';

class SearchMedicineNameCubit extends Cubit<List<DrugModel>> {
  final MedicationRepository medicationRepository;
  String? drugId;
  SearchMedicineNameCubit({required this.medicationRepository}) : super([]);

  Future<void> getDrugs(String searchQuery) async {
    if (searchQuery.trim().isEmpty) return;
    final result = await medicationRepository.getDrugs(searchQuery);
    result.fold((failure) => emit([]), (drugs) => emit(drugs));
  }

  static SearchMedicineNameCubit get(BuildContext context) {
    return BlocProvider.of<SearchMedicineNameCubit>(context);
  }
}
