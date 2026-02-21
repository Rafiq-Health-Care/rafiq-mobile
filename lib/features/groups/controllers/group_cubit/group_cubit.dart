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
    final allGroupResponse = await groupRepository.getAllGroups(request);
    allGroupResponse.fold(
      (failure) => emit(GroupError(message: failure.message)),
      (data) => emit(
        GroupLoaded(
          request: request,
          allGroups: data.content,
          currentGroups: data.content,
          hasReachedMax: data.lastPage,
          totalGroups: data.numberOfElements,
        ),
      ),
    );
  }

  Future<void> loadMoreGroups() async {
    final currentState = state;
    if (currentState is! GroupLoaded || currentState.hasReachedMax) {
      return;
    }
    final request = currentState.request.copyWith(
      page: currentState.request.page + 1,
    );

    final newResponse = await groupRepository.getAllGroups(request);
    newResponse.fold(
      (failure) {
        emit(GroupError(message: failure.message));
      },
      (data) {
        final allGroups = {...currentState.allGroups, ...data.content}.toList();
        emit(
          GroupLoaded(
            request: request,
            allGroups: allGroups,
            currentGroups: allGroups,
            hasReachedMax: data.lastPage,
            totalGroups: data.numberOfElements,
          ),
        );
      },
    );
  }

  void addGroup(GroupUpsertRequest group) async {
    final currentState = state;
    if (currentState is! GroupLoaded) return;

    final newGroup = await groupRepository.addGroup(group);
    newGroup.fold(
      (failure) {
        emit(GroupError(message: failure.message));
        // return previous state
        emit(currentState);
      },
      (data) {
        final allGroups = {
          ...currentState.allGroups,
          _groupDataToGroupContent(data),
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
      },
    );
  }

  void updateGroup(String id, GroupUpsertRequest newGroup) async {
    final currentState = state;
    if (currentState is! GroupLoaded) return;

    final updatedGroup = await groupRepository.updateGroup(id, newGroup);
    updatedGroup.fold(
      (failure) {
        emit(GroupError(message: failure.message));
        // return previous state
        emit(currentState);
      },
      (groupData) {
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
      },
    );
  }

  void deleteGroup(String id) async {
    final currentState = state;
    if (currentState is! GroupLoaded) return;

    final response = await groupRepository.deleteGroup(id);
    response.fold(
      (failure) {
        emit(GroupError(message: failure.message));
        // return previous state
        emit(currentState);
      },
      (data) {
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
      },
    );
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
