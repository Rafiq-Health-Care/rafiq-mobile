import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entities/consultation.dart';
import '../../domain/usecases/cancel_consultation.dart';
import '../../domain/usecases/get_consultation_details.dart';

part 'consultation_details_state.dart';

class DoctorConsultationDetailsCubit extends Cubit<ConsultationDetailsState> {
  final GetConsultationDetails getConsultationDetails;
  final CancelConsultation cancelConsultation;

  DoctorConsultationDetailsCubit({
    required this.getConsultationDetails,
    required this.cancelConsultation,
  }) : super(const ConsultationDetailsInitial());

  Future<void> fetchConsultationDetails(String slotId) async {
    emit(const ConsultationDetailsLoading());

    final result = await getConsultationDetails(
      GetConsultationDetailsParams(slotId: slotId),
    );

    result.fold(
      (failure) => emit(ConsultationDetailsError(failure.message)),
      (consultation) => emit(ConsultationDetailsLoaded(consultation)),
    );
  }

  Future<void> cancelSession({String? reason}) async {
    final current = state;
    if (current is! ConsultationDetailsLoaded) return;

    emit(ConsultationCancelling());

    final result = await cancelConsultation(
      CancelConsultationParams(
        consultationId: current.consultation.consultationId,
        reason: reason,
      ),
    );

    result.fold(
      (failure) {
        emit(ConsultationCancelError(failure.message));
        ConsultationDetailsLoaded(current.consultation);
      },
      (consultation) => emit(
        ConsultationDetailsLoaded(
          current.consultation.copyWith(status: ConsultationStatus.cancelled),
        ),
      ),
    );
  }
}
