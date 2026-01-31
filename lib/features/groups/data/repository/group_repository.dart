import 'package:rafiq/features/groups/data/models/group_upsert_request.dart';
import 'package:rafiq/features/groups/data/models/all_groups_request.dart';
import 'package:rafiq/features/groups/data/models/all_groups_response.dart';
import 'package:rafiq/features/groups/data/models/group_content_model.dart';
import 'package:rafiq/features/groups/data/models/group_data_model.dart';
import 'package:rafiq/features/groups/data/networking/group_service.dart';

class GroupRepository {
  final GroupService groupService;
  GroupRepository(this.groupService);

  Future<GroupDataModel> addGroup(GroupUpsertRequest request) async {
    final rawData = await groupService.addGroup(request);
    return GroupDataModel.fromJson(rawData);
  }

  Future<GroupContentModel> getGroupDetails(String groupId) async {
    final rawData = await groupService.getGroupDetails(groupId);
    return GroupContentModel.fromJson(rawData);
  }

  Future<void> deleteGroup(String groupId) async {
    await groupService.deleteGroup(groupId);
  }

  Future<GroupDataModel> updateGroup(
    String groupId,
    GroupUpsertRequest request,
  ) async {
    final rawData = await groupService.updateGroup(groupId, request);
    return GroupDataModel.fromJson(rawData);
  }

  Future<AllGroupsResponse> getAllGroups(AllGroupsRequest request) async {
    final rawData = await groupService.getAllGroups(request);
    return AllGroupsResponse.fromJson(rawData);
  }
}
