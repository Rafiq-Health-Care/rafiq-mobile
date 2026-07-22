import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rafiq/features/consultation/domain/entity/consultation_details_entity.dart';
import 'package:rafiq/features/consultation/domain/use_case/cancel_consultation_use_case.dart';
import 'package:rafiq/features/consultation/domain/use_case/get_patient_consultation_details_use_case.dart';

part 'consultation_details_state.dart';

class ConsultationDetailsCubit extends Cubit<ConsultationDetailsState> {
  final GetPatientConsultationDetailsUseCase consultationDetailsUseCase;
  final CancelConsultationUseCase cancelConsultationUseCase;
  ConsultationDetailsCubit({
    required this.consultationDetailsUseCase,
    required this.cancelConsultationUseCase,
  }) : super(ConsultationDetailsInitial());

  void consultationDetails({required String id}) async {
    emit(ConsultationDetailsLoading());
    final result = await consultationDetailsUseCase.call(id);
    result.fold(
      (failure) => emit(ConsultationDetailsError(message: failure.message)),
      (consultationDetails) => emit(
        ConsultationDetailsLoaded(consultationDetails: consultationDetails),
      ),
    );
  }

  void cancelConsultation({
    required String consultationId,
    required String reason,
  }) async {
    emit(ConsultationDetailsLoading());
    final result = await cancelConsultationUseCase.call(
      CancelConsultationParams(consultationId: consultationId),
    );
    result.fold(
      (_) => consultationDetails(id: consultationId),
      (_) => consultationDetails(id: consultationId),
    );
  }
}
