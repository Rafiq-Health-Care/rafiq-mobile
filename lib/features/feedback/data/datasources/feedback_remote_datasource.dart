import 'package:rafiq/core/networking/api_constants.dart';
import 'package:rafiq/core/networking/api_service.dart';
import 'package:rafiq/features/feedback/data/models/feedback_model.dart';

abstract class FeedbackRemoteDataSource {
  Future<void> addFeedback({
    required double rating,
    required String comment,
    required String consultationId,
  });

  Future<List<FeedbackModel>> getDoctorFeedback(String doctorId);
}

class FeedbackRemoteDataSourceImpl implements FeedbackRemoteDataSource {
  final ApiService _apiService;

  FeedbackRemoteDataSourceImpl(this._apiService);

  @override
  Future<void> addFeedback({
    required double rating,
    required String comment,
    required String consultationId,
  }) async {
    await _apiService.post(
      ApiConstants.feedback,
      data: {
        'rating': rating,
        'comment': comment,
        'consultationId': consultationId,
      },
    );
  }

  @override
  Future<List<FeedbackModel>> getDoctorFeedback(String doctorId) async {
    final response = await _apiService.get(
      ApiConstants.feedbackByDoctor(doctorId),
    );

    final data = response.data as List<dynamic>? ?? [];
    return data
        .map((item) => FeedbackModel.fromJson(item as Map<String, dynamic>))
        .toList();
  }
}
