import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rafiq/features/lab_test/data/models/lab_test_item_data.dart';

class LabTestFormCubit extends Cubit<List<LabTestItemData>> {
  LabTestFormCubit(super.initialTests);

  void addTest() {
    emit([
      ...state,
      LabTestItemData(
        nameController: TextEditingController(),
        valueController: TextEditingController(),
        unitController: TextEditingController(),
        statusController: TextEditingController(text: 'Normal'),
      ),
    ]);
  }

  void removeTest(int index) {
    final tests = List<LabTestItemData>.from(state);
    tests[index].dispose();
    tests.removeAt(index);
    emit(tests);
  }

  @override
  Future<void> close() {
    for (LabTestItemData item in state) {
      item.dispose();
    }
    return super.close();
  }
}
