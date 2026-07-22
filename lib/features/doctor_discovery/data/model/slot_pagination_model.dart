import 'package:rafiq/features/doctor_discovery/data/model/slot_model.dart';
import 'package:rafiq/features/doctor_discovery/domain/entity/slot_pagination_entity.dart';

class SlotPaginationModel {
  final List<SlotModel> slots;
  final int numberOfElements;
  final int size;
  final int totalPages;
  final bool lastPage;
  final bool firstPage;

  const SlotPaginationModel({
    required this.slots,
    required this.numberOfElements,
    required this.size,
    required this.totalPages,
    required this.lastPage,
    required this.firstPage,
  });

  factory SlotPaginationModel.fromJson(Map<String, dynamic> json) {
    return SlotPaginationModel(
      slots:
          (json['content'] as List<dynamic>?)
              ?.map((item) => SlotModel.fromJson(item as Map<String, dynamic>))
              .toList() ??
          [],
      numberOfElements: json['numberOfElements'] as int,
      size: json['size'] as int,
      totalPages: json['totalPages'] as int,
      lastPage: json['lastPage'] as bool,
      firstPage: json['firstPage'] as bool,
    );
  }

  SlotPaginationEntity toEntity() {
    return SlotPaginationEntity(
      slots: slots.map((e) => e.toEntity()).toList(),
      numberOfElements: numberOfElements,
      size: size,
      totalPages: totalPages,
      lastPage: lastPage,
      firstPage: firstPage,
    );
  }
}
