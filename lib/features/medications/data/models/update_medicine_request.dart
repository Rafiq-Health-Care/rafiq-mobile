import 'package:rafiq/features/medications/data/enums/medicine_status_enum.dart';
import 'package:rafiq/features/medications/data/enums/medicine_type_enum.dart';

class UpdateMedicineRequest {
  final String name;
  final String dosage;
  final String notes;
  final String frequency;
  final DateTime startDate;
  final DateTime endDate;
  final MedicineTypeEnum type;
  final MedicineStatusEnum status;
  final String reminderFrequency;
  final List<String> customDays;

  const UpdateMedicineRequest({
    required this.name,
    required this.dosage,
    required this.notes,
    required this.frequency,
    required this.startDate,
    required this.endDate,
    required this.type,
    required this.status,
    required this.reminderFrequency,
    required this.customDays,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'dosage': dosage,
      'notes': notes,
      'frequency': frequency,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      'type': type.typeStr(),
      'status': status.statusStr(),
      'reminderFrequency': reminderFrequency,
      'customDays': customDays,
    };
  }
}
