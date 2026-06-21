
import 'package:rafiq/features/Consultation/domain/entity/slot_entity.dart';

class SlotPaginationEntity {
  final List<SlotEntity> slots;
  final int numberOfElements;
  final int size;
  final int totalPages;
  final bool lastPage;
  final bool firstPage;

  const SlotPaginationEntity({
    required this.slots,
    required this.numberOfElements,
    required this.size,
    required this.totalPages,
    required this.lastPage,
    required this.firstPage,
  });
}