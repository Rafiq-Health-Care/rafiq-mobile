import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rafiq/features/auth/data/models/specialization_model.dart';
import 'package:rafiq/features/auth/data/repository/auth_repository.dart';
part 'specialization_state.dart';

class SpecializationCubit extends Cubit<SpecializationState> {
  final AuthRepository authRepository;
  SpecializationCubit(this.authRepository) : super(SpecializationInitial());

  Future<void> getSpecializations() async {
    emit(SpecializationLoading());
    final response = await authRepository.getSpecializationsRepository();
    response.fold(
      (failure) => emit(SpecializationFailure(failure.message)),
      (specializations) => emit(SpecializationSuccess(specializations)),
    );
  }

  static SpecializationCubit get(context) => BlocProvider.of(context);
}
