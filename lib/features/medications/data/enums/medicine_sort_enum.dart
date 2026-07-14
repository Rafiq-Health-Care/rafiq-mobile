enum MedicineSortEnum {
  name,
  dosage,
  frequency,
  reminderFrequency,
  startDate,
  endDate,
  type,
  status,
  createdAt,
  updatedAt;

  String sortStr() => this.name;

  String get displayName {
    switch (this) {
      case MedicineSortEnum.name:
        return 'Name';

      case MedicineSortEnum.dosage:
        return 'Dosage';

      case MedicineSortEnum.frequency:
        return 'Frequency';

      case MedicineSortEnum.reminderFrequency:
        return 'Reminder Frequency';

      case MedicineSortEnum.startDate:
        return 'Start Date';

      case MedicineSortEnum.endDate:
        return 'End Date';

      case MedicineSortEnum.type:
        return 'Medicine Type';

      case MedicineSortEnum.status:
        return 'Status';

      case MedicineSortEnum.createdAt:
        return 'Created Date';

      case MedicineSortEnum.updatedAt:
        return 'Last Modified';
    }
  }
}
