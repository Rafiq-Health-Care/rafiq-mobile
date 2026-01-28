enum MedicineStatusEnum {
  all,
  active,
  inactive,
  discontinued;

  factory MedicineStatusEnum.fromJson(String status) {
    return MedicineStatusEnum.values.firstWhere(
      (e) => e.statusStr() == status.toUpperCase(),
      orElse: () => MedicineStatusEnum.all,
    );
  }

  String? statusStr() {
    return name == MedicineStatusEnum.all.name ? null : name.toUpperCase();
  }
}
