enum MedicineTypeEnum {
  all,
  tablet,
  capsule,
  liquid,
  injection,
  topical,
  inhaler,
  suppository,
  patch,
  drops,
  powder,
  prescription,
  supplement,
  other;

  factory MedicineTypeEnum.fromJson(String? type) {
    return MedicineTypeEnum.values.firstWhere(
      (e) => e.typeStr() == type?.toUpperCase(),
      orElse: () => MedicineTypeEnum.all,
    );
  }

  String? typeStr() {
    return name == MedicineTypeEnum.all.name ? null : name.toUpperCase();
  }
}
