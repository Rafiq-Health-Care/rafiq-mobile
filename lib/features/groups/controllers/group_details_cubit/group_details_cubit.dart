import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rafiq/features/groups/data/models/group_content_model.dart';
import 'package:rafiq/features/groups/data/repository/group_repository.dart';
import 'package:rafiq/features/medications/data/models/all_medicines_content_model.dart';

part 'group_details_state.dart';

class GroupDetailsCubit extends Cubit<GroupDetailsState> {
  final GroupRepository groupRepository;
  GroupDetailsCubit(this.groupRepository) : super(GroupDetailsInitial());

  Future<void> getGroupDetails(
    String groupId, {
    bool needLoading = true,
  }) async {
    if (needLoading) {
      emit(GroupDetailsLoading());
    }
    final group = await groupRepository.getGroupDetails(groupId);
    group.fold(
      (failure) => emit(GroupDetailsError(message: failure.message)),
      (group) =>
          emit(GroupDetailsLoaded(group: group, medications: group.medicines)),
    );
  }

  void search(String query) {
    final currentState = state;
    if (currentState is! GroupDetailsLoaded) return;

    emit(
      currentState.copyWith(
        medications: currentState.group.medicines
            .where(
              (medication) =>
                  medication.name.toLowerCase().contains(query.toLowerCase()),
            )
            .toList(),
      ),
    );
  }

  Future<void> updateGroupDetails() async {
    final currentState = state;
    if (currentState is! GroupDetailsLoaded) return;

    await getGroupDetails(currentState.group.id, needLoading: false);
  }

  static GroupDetailsCubit of(BuildContext context) {
    return BlocProvider.of<GroupDetailsCubit>(context);
  }
}
