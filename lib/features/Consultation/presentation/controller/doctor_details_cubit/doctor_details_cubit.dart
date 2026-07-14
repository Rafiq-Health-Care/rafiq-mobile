import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rafiq/features/Consultation/domain/use_case/get_doctor_details_use_case.dart';
import 'doctor_details_state.dart';

class DoctorDetailsCubit extends Cubit<DoctorDetailsState> {
  final GetDoctorDetailsUseCase getDoctorDetailsUseCase;

  DoctorDetailsCubit({required this.getDoctorDetailsUseCase})
      : super(DoctorDetailsInitial());

  Future<void> getDoctorDetails(String id) async {
    emit(DoctorDetailsLoading());
    final result = await getDoctorDetailsUseCase.call(id);
    result.fold(
      (failure) => emit(DoctorDetailsFailure(message: failure.message)),
      (details) => emit(DoctorDetailsSuccess(details: details)),
    );
  }
}
