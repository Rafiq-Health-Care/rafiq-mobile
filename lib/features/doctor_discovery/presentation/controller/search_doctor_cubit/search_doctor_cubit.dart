import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rafiq/features/doctor_discovery/domain/entity/doctor_entity.dart';
import 'package:rafiq/features/doctor_discovery/domain/params/search_doctor_request.dart';
import 'package:rafiq/features/doctor_discovery/domain/params/search_doctors_params.dart';
import 'package:rafiq/features/doctor_discovery/domain/use_case/search_doctors_use_case.dart';

part 'search_doctor_state.dart';

class SearchDoctorCubit extends Cubit<SearchDoctorState> {
  final SearchDoctorsUseCase searchDoctorsUseCase;
  SearchDoctorCubit({required this.searchDoctorsUseCase})
    : super(SearchDoctorInitial());

  Future<void> searchDoctors({required SearchDoctorRequest request}) async {
    emit(SearchDoctorLoading());
    final res = await searchDoctorsUseCase.call(
      SearchDoctorsParams(page: request.page, filterBody: request.toBodyJson()),
    );
    res.fold((l) => emit(SearchDoctorFailure(message: l.message)), (r) {
      emit(
        SearchDoctorSuccess(
          request: request,
          doctors: r.doctors,
          isLastPage: r.isLastPage,
        ),
      );
    });
  }

  Future<void> getMoreDoctors() async {
    final currentState = state;
    if (currentState is! SearchDoctorSuccess || currentState.isLastPage) return;

    final res = await searchDoctorsUseCase.call(
      SearchDoctorsParams(
        page: currentState.request.page + 1,
        filterBody: currentState.request.toBodyJson(),
      ),
    );

    res.fold((l) => emit(SearchDoctorFailure(message: l.message)), (r) {
      emit(
        SearchDoctorSuccess(
          request: currentState.request.copyWith(
            page: currentState.request.page + 1,
          ),
          doctors: currentState.doctors + r.doctors,
          isLastPage: r.isLastPage,
        ),
      );
    });
  }

  Future<void> refresh() async {
    final currentState = state;
    if (currentState is SearchDoctorSuccess) {
      searchDoctors(request: currentState.request.copyWith(page: 0));
    } else {
      searchDoctors(request: SearchDoctorRequest());
    }
  }
}
