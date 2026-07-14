import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rafiq/features/Consultation/domain/entity/consultation_details_entity.dart';
import 'package:rafiq/features/Consultation/domain/use_case/consultation_details_use_case.dart';
import 'package:rafiq/features/consultation_details/domain/usecases/cancel_consultation.dart';

part 'consultation_details_state.dart';

class ConsultationDetailsCubit extends Cubit<ConsultationDetailsState> {
  final ConsultationDetailsUseCase consultationDetailsUseCase;
  final CancelConsultation cancelConsultationUseCase;
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
