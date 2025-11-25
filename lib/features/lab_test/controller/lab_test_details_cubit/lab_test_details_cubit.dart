import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rafiq/features/lab_test/data/models/lab_test_results_model.dart';
import 'package:rafiq/features/lab_test/data/repository/lab_test_repository.dart';

part 'lab_test_details_state.dart';

class LabTestDetailsCubit extends Cubit<LabTestDetailsState> {
  final LabTestRepository labTestRepository;
  LabTestDetailsCubit(this.labTestRepository) : super(LabTestDetailsInitial());

  void getLabTestDetails(String testId) {
    emit(LabTestDetailsLoading());
    labTestRepository
        .getTestLabDetails(testId)
        .then((value) {
          emit(LabTestDetailsSuccess());
        })
        .catchError((error) {
          emit(LabTestDetailsError(error.toString()));
        });
  }

  void updateLabTestResults(LabTestResultsModel results) {
    emit(LabTestDetailsLoading());
    labTestRepository
        .updateLabTestResults(results)
        .then((_) {
          emit(LabTestDetailsSuccess());
        })
        .catchError((error) {
          emit(LabTestDetailsError(error.toString()));
        });
  }

  static LabTestDetailsCubit get(context) => BlocProvider.of(context);
}
