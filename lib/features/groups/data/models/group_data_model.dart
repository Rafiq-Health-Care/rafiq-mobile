class GroupDataModel {
  final String groupId;
  final String patientId;
  final String name;
  final String description;
  final String color;
  final String? iconUrl;
  final int medicineCount;
  final DateTime createdAt;
  final DateTime updatedAt;

  GroupDataModel({
    required this.groupId,
    required this.patientId,
    required this.name,
    required this.description,
    required this.color,
    this.iconUrl,
    required this.medicineCount,
    required this.createdAt,
    required this.updatedAt,
  });

  factory GroupDataModel.fromJson(Map<String, dynamic> json) {
    return GroupDataModel(
      groupId: json['groupId'],
      patientId: json['patientId'],
      name: json['name'],
      description: json['description'],
      color: json['color'],
      iconUrl: json['iconUrl'],
      medicineCount: json['medicineCount'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}
