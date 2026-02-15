import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rafiq/features/groups/data/models/group_upsert_request.dart';
import 'package:rafiq/features/groups/data/models/all_groups_request.dart';
import 'package:rafiq/features/groups/data/models/group_content_model.dart';
import 'package:rafiq/features/groups/data/models/group_data_model.dart';
import 'package:rafiq/features/groups/data/repository/group_repository.dart';

part 'group_state.dart';

class GroupCubit extends Cubit<GroupState> {
  final GroupRepository groupRepository;
  GroupCubit(this.groupRepository) : super(GroupInitial());

  Future<void> loadGroups(
    AllGroupsRequest request, {
    bool needLoading = true,
  }) async {
    if (needLoading) {
      emit(GroupLoading());
    }
    try {
      final allGroupResponse = await groupRepository.getAllGroups(request);
      emit(
        GroupLoaded(
          request: request,
          allGroups: allGroupResponse.content,
          currentGroups: allGroupResponse.content,
          hasReachedMax: allGroupResponse.lastPage,
          totalGroups: allGroupResponse.numberOfElements,
        ),
      );
    } catch (e) {
      emit(GroupError(message: e.toString()));
    }
  }

  Future<void> loadMoreGroups() async {
    final currentState = state;
    if (currentState is! GroupLoaded || currentState.hasReachedMax) {
      return;
    }
    try {
      final request = currentState.request.copyWith(
        page: currentState.request.page + 1,
      );

      final newResponse = await groupRepository.getAllGroups(request);
      final allGroups = {
        ...currentState.allGroups,
        ...newResponse.content,
      }.toList();

      emit(
        GroupLoaded(
          request: request,
          allGroups: allGroups,
          currentGroups: allGroups,
          hasReachedMax: newResponse.lastPage,
          totalGroups: newResponse.numberOfElements,
        ),
      );
    } catch (e) {
      emit(GroupError(message: e.toString()));
    }
  }

  void addGroup(GroupUpsertRequest group) async {
    final currentState = state;
    if (currentState is! GroupLoaded) return;

    try {
      final newGroup = await groupRepository.addGroup(group);
      final allGroups = {
        ...currentState.allGroups,
        _groupDataToGroupContent(newGroup),
      }.toList();

      emit(
        GroupLoaded(
          request: currentState.request,
          allGroups: allGroups,
          currentGroups: allGroups,
          hasReachedMax: currentState.hasReachedMax,
          totalGroups: currentState.totalGroups + 1,
        ),
      );
    } catch (e) {
      emit(GroupError(message: e.toString()));

      // return previous state
      emit(currentState);
    }
  }

  void updateGroup(String id, GroupUpsertRequest newGroup) async {
    final currentState = state;
    if (currentState is! GroupLoaded) return;

    try {
      await groupRepository.updateGroup(id, newGroup);
      final allGroups = currentState.allGroups.map((group) {
        if (group.id == id) {
          return group.copyWith(
            name: newGroup.name,
            description: newGroup.description,
            color: newGroup.color,
          );
        }
        return group;
      }).toList();

      final currentGroups = currentState.currentGroups.map((group) {
        if (group.id == id) {
          return group.copyWith(
            name: newGroup.name,
            description: newGroup.description,
            color: newGroup.color,
          );
        }
        return group;
      }).toList();

      emit(
        GroupLoaded(
          request: currentState.request,
          allGroups: allGroups,
          currentGroups: currentGroups,
          hasReachedMax: currentState.hasReachedMax,
          totalGroups: currentState.totalGroups,
        ),
      );
    } catch (e) {
      emit(GroupError(message: e.toString()));

      // return previous state
      emit(currentState);
    }
  }

  void deleteGroup(String id) async {
    final currentState = state;
    if (currentState is! GroupLoaded) return;

    try {
      await groupRepository.deleteGroup(id);
      emit(
        GroupLoaded(
          request: currentState.request.copyWith(
            page: currentState.request.page - 1,
          ),
          allGroups: currentState.allGroups
              .where((group) => group.id != id)
              .toList(),
          currentGroups: currentState.currentGroups
              .where((group) => group.id != id)
              .toList(),
          hasReachedMax: currentState.hasReachedMax,
          totalGroups: currentState.totalGroups - 1,
        ),
      );
    } catch (e) {
      emit(GroupError(message: e.toString()));

      // return previous state
      emit(currentState);
    }
  }

  GroupContentModel _groupDataToGroupContent(GroupDataModel groupData) {
    return GroupContentModel(
      id: groupData.groupId,
      patientId: groupData.patientId,
      name: groupData.name,
      description: groupData.description,
      color: groupData.color,
      medicineCount: groupData.medicineCount,
      medicines: [],
      createdAt: groupData.createdAt,
      updatedAt: groupData.updatedAt,
    );
  }

  void search(String query) {
    final currentState = state;
    if (currentState is! GroupLoaded) return;

    emit(
      currentState.copyWith(
        currentGroups: _getCurrentGroups(query, currentState.allGroups),
      ),
    );
  }

  Future<void> refresh() async {
    await loadGroups(AllGroupsRequest());
  }

  List<GroupContentModel> _getCurrentGroups(
    String query,
    List<GroupContentModel> allGroups,
  ) {
    return allGroups
        .where(
          (group) => group.name.toLowerCase().contains(query.toLowerCase()),
        )
        .toList();
  }

  static GroupCubit of(BuildContext context) => context.read<GroupCubit>();
}
