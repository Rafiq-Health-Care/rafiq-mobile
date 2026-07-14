import 'package:rafiq/core/networking/api_constants.dart';
import 'package:rafiq/core/networking/api_service.dart';
import 'package:rafiq/features/schedule/data/models/slot_model.dart';

abstract class ScheduleRemoteDataSource {
  Future<SlotSearchPage> searchSlots({
    required DateTime startDate,
    required DateTime endDate,
    String? status,
    int page = 0,
    int size = 100,
  });
}

class ScheduleRemoteDataSourceImpl implements ScheduleRemoteDataSource {
  final ApiService _apiService;

  ScheduleRemoteDataSourceImpl(this._apiService);

  @override
  Future<SlotSearchPage> searchSlots({
    required DateTime startDate,
    required DateTime endDate,
    String? status,
    int page = 0,
    int size = 100,
  }) async {
    final response = await _apiService.post(
      ApiConstants.doctorSchedule,
      queryParameters: {'page': page, 'size': size},
      data: {
        'startDate': startDate.toUtc().toIso8601String(),
        'endDate': endDate.toUtc().toIso8601String(),
        if (status != null) 'status': status,
      },
    );

    return SlotSearchPage.fromJson(response.data as Map<String, dynamic>);
  }
}
