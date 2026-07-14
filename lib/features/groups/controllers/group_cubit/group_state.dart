part of 'group_cubit.dart';

sealed class GroupState extends Equatable {
  const GroupState();

  @override
  List<Object> get props => [];
}

final class GroupInitial extends GroupState {}

final class GroupLoading extends GroupState {}

final class GroupLoaded extends GroupState {
  final AllGroupsRequest request;
  final List<GroupContentModel> allGroups;
  final List<GroupContentModel> currentGroups;
  final bool hasReachedMax;
  final int totalGroups;

  const GroupLoaded({
    required this.request,
    required this.allGroups,
    required this.currentGroups,
    required this.hasReachedMax,
    required this.totalGroups,
  });

  GroupLoaded copyWith({
    AllGroupsRequest? request,
    List<GroupContentModel>? allGroups,
    List<GroupContentModel>? currentGroups,
    bool? hasReachedMax,
    int? totalGroups,
  }) {
    return GroupLoaded(
      request: request ?? this.request,
      allGroups: allGroups ?? this.allGroups,
      currentGroups: currentGroups ?? this.currentGroups,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      totalGroups: totalGroups ?? this.totalGroups,
    );
  }

  @override
  List<Object> get props => [
    request,
    allGroups,
    currentGroups,
    hasReachedMax,
    totalGroups,
  ];
}

final class GroupError extends GroupState {
  final String message;
  const GroupError({required this.message});

  @override
  List<Object> get props => [message];
}
