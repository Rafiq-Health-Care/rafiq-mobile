import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rafiq/features/lab_test/data/models/content_model.dart';
import 'package:rafiq/features/lab_test/data/models/lab_test_get_all_request.dart';
import 'package:rafiq/features/lab_test/data/models/lab_test_results_model.dart';
import 'package:rafiq/features/lab_test/data/repository/lab_test_repository.dart';

part 'lab_test_state.dart';

class LabTestCubit extends Cubit<LabTestState> {
  final LabTestRepository labTestRepository;
  LabTestCubit(this.labTestRepository) : super(LabTestInitial());
  List<ContentModel> _labTestsContent = [];
  List<ContentModel> get labTestsContent => _labTestsContent;

  void getAllLabTests(LabTestGetAllRequest request) {
    emit(LabTestLoading());
    labTestRepository
        .getAllLabTests(request)
        .then((value) {
          if (value.content.isEmpty) {
            emit(LabTestEmpty());
          } else {
            _labTestsContent = value.content;
            emit(LabTestSuccess());
          }
        })
        .catchError((error) {
          emit(LabTestError(error.toString()));
        });
  }

  void deleteAllLabTests() {
    emit(LabTestLoading());
    labTestRepository
        .deleteAllTestLabs()
        .then((_) {
          _labTestsContent.clear();
          emit(LabTestSuccess());
        })
        .catchError((error) {
          emit(LabTestError(error.toString()));
        });
  }

  void deleteLabTest(String testId) {
    emit(LabTestLoading());
    labTestRepository
        .deleteTestLab(testId)
        .then((_) {
          _labTestsContent.removeWhere((element) => element.testId == testId);
          emit(LabTestSuccess());
        })
        .catchError((error) {
          emit(LabTestError(error.toString()));
        });
  }

  void saveLabTestResults(LabTestResultsModel results) {
    emit(LabTestLoading());
    labTestRepository
        .saveLabTestResults(results)
        .then((_) {
          emit(LabTestSuccess());
        })
        .catchError((error) {
          emit(LabTestError(error.toString()));
        });
  }

  static LabTestCubit get(context) => BlocProvider.of(context);
}
