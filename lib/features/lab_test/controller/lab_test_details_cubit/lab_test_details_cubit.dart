import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rafiq/features/lab_test/data/models/lab_test_results_model.dart';
import 'package:rafiq/features/lab_test/data/models/lab_test_details_model.dart';
import 'package:rafiq/features/lab_test/data/repository/lab_test_repository.dart';

part 'lab_test_details_state.dart';

class LabTestDetailsCubit extends Cubit<LabTestDetailsState> {
  final LabTestRepository labTestRepository;
  LabTestDetailsCubit(this.labTestRepository) : super(LabTestDetailsInitial());

  Future<void> getLabTestDetails(String testId) async {
    emit(LabTestDetailsLoading());
    final response = await labTestRepository.getTestLabDetails(testId);
    response.fold(
      (failure) {
        emit(LabTestDetailsError(failure.message));
      },
      (data) {
        emit(LabTestDetailsLoaded(data));
      },
    );
  }

  Future<void> updateLabTestResults(
    LabTestResultsModel results,
    String testId,
  ) async {
    emit(LabTestDetailsLoading());
    final response = await labTestRepository.updateLabTestResults(
      results,
      testId,
    );
    response.fold(
      (failure) {
        emit(LabTestDetailsError(failure.message));
      },
      (data) {
        emit(LabTestDetailsUpdated(data));
      },
    );
  }

  static LabTestDetailsCubit get(context) => BlocProvider.of(context);
}
