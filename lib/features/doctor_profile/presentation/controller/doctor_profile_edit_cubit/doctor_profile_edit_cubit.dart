import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rafiq/features/doctor_profile/data/models/update_basic_info_request.dart';
import 'package:rafiq/features/doctor_profile/data/models/upsert_experience_request.dart';
import 'package:rafiq/features/doctor_profile/data/repository/doctor_profile_repository.dart';

part 'doctor_profile_edit_state.dart';

/// One cubit instance is created per edit screen (see AppRouter), so its
/// state only ever reflects that single in-flight submission.
class DoctorProfileEditCubit extends Cubit<DoctorProfileEditState> {
  final DoctorProfileRepository repository;
  DoctorProfileEditCubit(this.repository) : super(DoctorProfileEditInitial());

  Future<void> updateBasicInfo(UpdateBasicInfoRequest request) async {
    emit(DoctorProfileEditSubmitting());
    final result = await repository.updateBasicInfo(request);
    result.fold(
      (failure) => emit(DoctorProfileEditFailure(failure.message)),
      (_) => emit(DoctorProfileEditSuccess()),
    );
  }

  Future<void> updateBiography(String biography) async {
    emit(DoctorProfileEditSubmitting());
    final result = await repository.updateBiography(biography);
    result.fold(
      (failure) => emit(DoctorProfileEditFailure(failure.message)),
      (_) => emit(DoctorProfileEditSuccess()),
    );
  }

  Future<void> setPrice(double price) async {
    emit(DoctorProfileEditSubmitting());
    final result = await repository.setPrice(price);
    result.fold(
      (failure) => emit(DoctorProfileEditFailure(failure.message)),
      (_) => emit(DoctorProfileEditSuccess()),
    );
  }

  /// [experienceId] is null when adding a brand-new experience entry, and
  /// set to the existing entry's id when editing one — same screen and
  /// same request shape either way, just a different endpoint.
  Future<void> upsertExperience(
    UpsertExperienceRequest request, {
    String? experienceId,
  }) async {
    emit(DoctorProfileEditSubmitting());
    final result = experienceId == null
        ? await repository.addExperience(request)
        : await repository.updateExperience(experienceId, request);
    result.fold(
      (failure) => emit(DoctorProfileEditFailure(failure.message)),
      (_) => emit(DoctorProfileEditSuccess()),
    );
  }

  static DoctorProfileEditCubit get(context) => BlocProvider.of(context);
}
