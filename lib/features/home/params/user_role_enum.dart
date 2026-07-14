enum UserRoleEnum {
  patient,
  doctor;

  factory UserRoleEnum.fromString(String name) =>
      values.firstWhere((role) => name.toLowerCase().contains(role.name));
}
