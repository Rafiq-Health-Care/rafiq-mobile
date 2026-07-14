import 'package:rafiq/features/medications/data/enums/medicine_bulk_actions_enum.dart';

class MedicinesBulkRequest {
  final List<String> medicineIds;
  final MedicineBulkActionsEnum action;
  final String? groupId;

  const MedicinesBulkRequest({
    required this.medicineIds,
    required this.action,
    this.groupId,
  });

  Map<String, dynamic> toJson() {
    return {
      'medicineIds': medicineIds,
      'action': action.bulkActionStr,
      'groupId': groupId,
    };
  }
}
