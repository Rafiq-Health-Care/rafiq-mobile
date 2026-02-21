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

    final response = await labTestRepository.getAllLabTests(request);
    response.fold(
      (failure) {
        _isLoadingMore = false;
        emit(LabTestError(failure.message));
      },
      (data) {
        if (data.content.isEmpty && _page == 0) {
          emit(LabTestEmpty());
        } else {
          _labTestsContent.addAll(data.content);
          _lastPage = data.lastPage;
          if (!_lastPage) {
            _page++;
          }
          _isLoadingMore = false;
          emit(LabTestSuccess());
        }
      },
    );
  }

  Future<void> refreshLabTests() async {
    await getAllLabTests(isRefresh: true);
  }

  Future<void> loadMoreLabTests() async {
    await getAllLabTests();
  }

  Future<void> deleteAllLabTests() async {
    emit(LabTestLoading());
    final response = await labTestRepository.deleteAllTestLabs();
    response.fold((failure) => emit(LabTestError(failure.message)), (_) {
      _labTestsContent.clear();
      _lastPage = false;
      _page = 0;
      emit(LabTestEmpty());
    });
  }

  Future<void> deleteLabTest(String testId) async {
    emit(LabTestLoading());
    final response = await labTestRepository.deleteTestLab(testId);
    response.fold((failure) => emit(LabTestError(failure.message)), (_) {
      _labTestsContent.removeWhere((element) => element.testId == testId);
      if (_labTestsContent.isEmpty) {
        _lastPage = false;
        _page = 0;
        emit(LabTestEmpty());
      } else {
        emit(LabTestSuccess());
      }
    });
  }

  Future<void> saveLabTestResults(LabTestResultsModel results) async {
    emit(LabTestLoading());
    final response = await labTestRepository.saveLabTestResults(results);
    response.fold(
      (failure) => emit(LabTestError(failure.message)),
      (data) => emit(LabTestSuccess()),
    );
  }

  static LabTestCubit get(context) => BlocProvider.of(context);
}
