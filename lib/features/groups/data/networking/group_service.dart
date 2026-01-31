import 'package:rafiq/core/networking/api_constants.dart';
import 'package:rafiq/core/networking/api_service.dart';
import 'package:rafiq/features/groups/data/models/group_upsert_request.dart';
import 'package:rafiq/features/groups/data/models/all_groups_request.dart';

class GroupService {
  final ApiService _api;
  GroupService({required ApiService api}) : _api = api;

  Future<dynamic> addGroup(GroupUpsertRequest request) async {
    try {
      final response = await _api.post(
        ApiConstants.addGroup,
        data: request.toJson(),
      );
      return response.data['data'];
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> getGroupDetails(String groupId) async {
    try {
      final response = await _api.get('${ApiConstants.group}/$groupId');
      return response.data['data'];
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteGroup(String groupId) async {
    try {
      await _api.delete('${ApiConstants.group}/$groupId');
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> updateGroup(
    String groupId,
    GroupUpsertRequest request,
  ) async {
    try {
      final response = await _api.patch(
        '${ApiConstants.group}/$groupId',
        data: request.toJson(),
      );
      return response.data['data'];
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> getAllGroups(AllGroupsRequest request) async {
    try {
      final response = await _api.get(
        ApiConstants.group,
        queryParameters: request.toJson(),
      );
      return response.data;
    } catch (e) {
      rethrow;
    }
  }
}
