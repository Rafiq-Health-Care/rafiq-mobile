import 'package:rafiq/features/Consultation/domain/entity/slot_entity.dart';

class SlotModel {
  final String id;
  final DateTime startTime;
  final DateTime endTime;

  const SlotModel({
    required this.id,
    required this.startTime,
    required this.endTime,
  });

  factory SlotModel.fromJson(Map<String, dynamic> json) {
    return SlotModel(
      id: json['id'] as String,
      startTime: DateTime.parse(json['startTime'] as String),
      endTime: DateTime.parse(json['endTime'] as String),
    );
  }

  SlotEntity toEntity() {
    return SlotEntity(id: id, startTime: startTime, endTime: endTime);
  }
}
