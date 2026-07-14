import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SelectedMedicationCubit extends Cubit<Set<String>> {
  SelectedMedicationCubit() : super({});

  void toggleSelection(String id) {
    final newSelection = Set<String>.from(state);
    if (newSelection.contains(id)) {
      newSelection.remove(id);
    } else {
      newSelection.add(id);
    }
    emit(newSelection);
  }

  void selectAll(List<String> allIds) {
    emit(Set.from(allIds));
  }

  void clearSelection() {
    emit({});
  }

  static SelectedMedicationCubit of(BuildContext context) {
    return context.read<SelectedMedicationCubit>();
  }
}
