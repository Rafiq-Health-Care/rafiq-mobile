
import 'package:rafiq/features/schedule/domain/entities/slot_entity.dart';
import 'package:rafiq/features/schedule/domain/entities/slot_status.dart';

class SlotModel extends SlotEntity {
  const SlotModel({
    required super.slotId,
    required super.startTime,
    required super.durationInMinutes,
    required super.status,
    super.patientName,
    super.consultationId,
  });

  factory SlotModel.fromJson(Map<String, dynamic> json) {
    return SlotModel(
      slotId: json['slotId'] as String? ?? '',
      patientName: json['patientName'] as String?,
      startTime: DateTime.parse(json['startTime'] as String).toLocal(),
      durationInMinutes: (json['durationInMinutes'] as num?)?.toInt() ?? 30,
      status: SlotStatusX.fromApi(json['status'] as String? ?? 'AVAILABLE'),
      consultationId: json['consultationId'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'slotId': slotId,
        'patientName': patientName,
        'startTime': startTime.toUtc().toIso8601String(),
        'durationInMinutes': durationInMinutes,
        'status': status.apiValue,
        'consultationId': consultationId,
      };
}

/// Wraps the Spring-style paginated envelope the endpoint returns.
class SlotSearchPage {
  final List<SlotModel> content;
  final int numberOfElements;
  final int size;
  final int totalPages;
  final bool lastPage;
  final bool firstPage;

  const SlotSearchPage({
    required this.content,
    required this.numberOfElements,
    required this.size,
    required this.totalPages,
    required this.lastPage,
    required this.firstPage,
  });

  factory SlotSearchPage.fromJson(Map<String, dynamic> json) {
    return SlotSearchPage(
      content: (json['content'] as List<dynamic>? ?? [])
          .map((e) => SlotModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      numberOfElements: (json['numberOfElements'] as num?)?.toInt() ?? 0,
      size: (json['size'] as num?)?.toInt() ?? 0,
      totalPages: (json['totalPages'] as num?)?.toInt() ?? 0,
      lastPage: json['lastPage'] as bool? ?? true,
      firstPage: json['firstPage'] as bool? ?? true,
    );
  }
}
