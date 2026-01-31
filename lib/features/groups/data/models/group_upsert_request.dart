class GroupUpsertRequest {
  final String name;
  final String description;
  final String color;

  GroupUpsertRequest({
    required this.name,
    required this.description,
    required this.color,
  });

  Map<String, dynamic> toJson() {
    return {"name": name, "description": description, "color": color};
  }
}
