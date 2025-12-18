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
  final List<ContentModel> _labTestsContent = [];
  bool _lastPage = false;
  int _page = 0;
  List<ContentModel> get labTestsContent => _labTestsContent;
  bool get lastPage => _lastPage;
  bool _isLoadingMore = false;
  bool get isLoadingMore => _isLoadingMore;

  Future<void> getAllLabTests({bool isRefresh = false}) async {
    if (isRefresh) {
      _page = 0;
      _lastPage = false;
      _labTestsContent.clear();
    }

    if (_lastPage ||
        (state is LabTestLoading && !isRefresh) ||
        _isLoadingMore) {
      return;
    }

    if (_page == 0) {
      emit(LabTestLoading(isFirstFetch: true));
    } else {
      _isLoadingMore = true;
      emit(
        LabTestSuccess(),
      ); // Emit success to update UI with loading indicator if needed, or just keep current state
    }

    final LabTestGetAllRequest request = LabTestGetAllRequest(
      page: _page,
      size: 20,
    );

    try {
      final value = await labTestRepository.getAllLabTests(request);

      if (value.content.isEmpty && _page == 0) {
        emit(LabTestEmpty());
      } else {
        _labTestsContent.addAll(value.content);
        _lastPage = value.lastPage;
        if (!_lastPage) {
          _page++;
        }
        _isLoadingMore = false;
        emit(LabTestSuccess());
      }
    } catch (error) {
      _isLoadingMore = false;
      emit(LabTestError(error.toString()));
    }
  }

  Future<void> refreshLabTests() async {
    await getAllLabTests(isRefresh: true);
  }

  void loadMoreLabTests() {
    getAllLabTests();
  }

  void deleteAllLabTests() {
    emit(LabTestLoading());
    labTestRepository
        .deleteAllTestLabs()
        .then((_) {
          _labTestsContent.clear();
          _lastPage = false;
          _page = 0;
          emit(LabTestEmpty());
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
          if (_labTestsContent.isEmpty) {
            _lastPage = false;
            _page = 0;
            emit(LabTestEmpty());
          } else {
            emit(LabTestSuccess());
          }
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
