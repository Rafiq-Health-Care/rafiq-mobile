import 'package:rafiq/core/networking/api_constants.dart';
import 'package:rafiq/core/networking/api_service.dart';
import 'package:rafiq/features/call/data/model/agora_model.dart';

abstract class CallRemoteDataSource {
  Future<AgoraModel> joinCall({required String consultationId});
  Future<void> leaveCall({required String consultationId});
}

class CallRemoteDataSourceImpl implements CallRemoteDataSource {
  final ApiService apiService;

  CallRemoteDataSourceImpl(this.apiService);
  @override
  Future<AgoraModel> joinCall({required String consultationId}) async {
    final response = await apiService.post(
      ApiConstants.getEnterCall(consultationId),
    );
    return AgoraModel.fromJson(response.data);
    // return AgoraModel(
    //   channelName: 'test',
    //   token:
    //       '007eJxTYDjlwDg9LvjJ5pLY3gjlx7eebv/xP008sXNReeLhn0cKnWMUGBItjI1SDVLNzYySU02Mk82Tkg3MzQ2SUo2BpHmKmYH3freshkBGht3b7zAxMkAgiM/CUJJaXMLAAADmtCHH',
    // );
  }

  @override
  Future<void> leaveCall({required String consultationId}) async {
    await apiService.post(ApiConstants.getLeaveCall(consultationId));
  }
}
