import 'package:rafiq/features/medications/data/enums/medicine_sort_enum.dart';
import 'package:rafiq/features/medications/data/enums/medicine_status_enum.dart';
import 'package:rafiq/features/medications/data/enums/medicine_type_enum.dart';

class AllMedicinesRequest {
  final int page;
  final int size;
  final MedicineSortEnum sort;
  final String? search;
  final MedicineStatusEnum? status;
  final String? groupId;
  final MedicineTypeEnum? type;

  const AllMedicinesRequest({
    this.page = 0,
    this.size = 10,
    this.sort = MedicineSortEnum.name,
    this.search,
    this.status,
    this.groupId,
    this.type,
  });

  Map<String, dynamic> toJson() {
    return {
      'page': page,
      'size': size,
      'sort': sort.sortStr(),
      'search': search,
      'status': status?.statusStr(),
      // 'groupId': groupId,
      'type': type?.typeStr(),
    };
  }

  AllMedicinesRequest copyWith({
    int? page,
    int? size,
    MedicineSortEnum? sort,
    String? search,
    MedicineStatusEnum? status,
    String? groupId,
    MedicineTypeEnum? type,
  }) {
    return AllMedicinesRequest(
      page: page ?? this.page,
      size: size ?? this.size,
      sort: sort ?? this.sort,
      search: search ?? this.search,
      status: status ?? this.status,
      groupId: groupId == '' ? null : (groupId ?? this.groupId),
      type: type ?? this.type,
    );
  }
}
