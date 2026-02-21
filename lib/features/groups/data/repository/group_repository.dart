import 'package:dartz/dartz.dart';
import 'package:rafiq/core/errors/failure.dart';
import 'package:rafiq/features/groups/data/models/group_upsert_request.dart';
import 'package:rafiq/features/groups/data/models/all_groups_request.dart';
import 'package:rafiq/features/groups/data/models/all_groups_response.dart';
import 'package:rafiq/features/groups/data/models/group_content_model.dart';
import 'package:rafiq/features/groups/data/models/group_data_model.dart';
import 'package:rafiq/features/groups/data/networking/group_service.dart';

class GroupRepository {
  final GroupService groupService;
  GroupRepository(this.groupService);

  Future<Either<Failure, GroupDataModel>> addGroup(
    GroupUpsertRequest request,
  ) async {
    final rawData = await groupService.addGroup(request);
    return rawData.fold(
      (failure) => Left(failure),
      (data) => Right(GroupDataModel.fromJson(data)),
    );
  }

  Future<Either<Failure, GroupContentModel>> getGroupDetails(
    String groupId,
  ) async {
    final rawData = await groupService.getGroupDetails(groupId);
    return rawData.fold(
      (failure) => Left(failure),
      (data) => Right(GroupContentModel.fromJson(data)),
    );
  }

  Future<Either<Failure, void>> deleteGroup(String groupId) async {
    final response = await groupService.deleteGroup(groupId);
    return response.fold((failure) => Left(failure), (_) => Right(null));
  }

  Future<Either<Failure, GroupDataModel>> updateGroup(
    String groupId,
    GroupUpsertRequest request,
  ) async {
    final rawData = await groupService.updateGroup(groupId, request);
    return rawData.fold(
      (failure) => Left(failure),
      (data) => Right(GroupDataModel.fromJson(data)),
    );
  }

  Future<Either<Failure, AllGroupsResponse>> getAllGroups(
    AllGroupsRequest request,
  ) async {
    final rawData = await groupService.getAllGroups(request);
    return rawData.fold(
      (failure) => Left(failure),
      (data) => Right(AllGroupsResponse.fromJson(data)),
    );
  }
}
