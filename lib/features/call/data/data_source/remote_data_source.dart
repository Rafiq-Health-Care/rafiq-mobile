import 'package:rafiq/core/networking/api_constants.dart';
import 'package:rafiq/core/networking/api_service.dart';
import 'package:rafiq/features/call/data/model/agora_model.dart';

abstract class RemoteDataSource {
  Future<AgoraModel> joinCall({required String consultationId});
  Future<void> leaveCall({required String consultationId});
}

class RemoteDataSourceImpl implements RemoteDataSource {
  final ApiService apiService;

  RemoteDataSourceImpl(this.apiService);
  @override
  Future<AgoraModel> joinCall({required String consultationId}) async {
    final response = await apiService.post(
      ApiConstants.getEnterCall(consultationId),
    );
    return AgoraModel.fromJson(response.data);
  }

  @override
  Future<void> leaveCall({required String consultationId}) async {
    await apiService.post(ApiConstants.getLeaveCall(consultationId));
  }
}
