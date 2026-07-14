part of 'group_details_cubit.dart';

sealed class GroupDetailsState extends Equatable {
  const GroupDetailsState();

  @override
  List<Object> get props => [];
}

final class GroupDetailsInitial extends GroupDetailsState {}

final class GroupDetailsLoading extends GroupDetailsState {}

final class GroupDetailsLoaded extends GroupDetailsState {
  final GroupContentModel group;
  final List<AllMedicinesContentModel> medications;
  const GroupDetailsLoaded({required this.group, required this.medications});

  GroupDetailsLoaded copyWith({
    GroupContentModel? group,
    List<AllMedicinesContentModel>? medications,
  }) {
    return GroupDetailsLoaded(
      group: group ?? this.group,
      medications: medications ?? this.medications,
    );
  }

  @override
  List<Object> get props => [group, medications];
}

final class GroupDetailsError extends GroupDetailsState {
  final String message;
  const GroupDetailsError({required this.message});

  @override
  List<Object> get props => [message];
}
