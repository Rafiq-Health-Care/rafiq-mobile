import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rafiq/features/landing/data/networking/landing_service.dart';

part 'landing_state.dart';

class LandingCubit extends Cubit<LandingState> {
  final LandingService landingService;
  LandingCubit(this.landingService) : super(LandingInitial());

  Future<void> refresh() async {
    emit(LandingLoading());
    final result = await landingService.refresh();
    result.fold(
      (failure) => emit(LandingFailure(message: failure.message)),
      (role) => emit(LandingSuccess(role: role)),
    );
  }

  static LandingCubit get(context) => BlocProvider.of(context);
}
