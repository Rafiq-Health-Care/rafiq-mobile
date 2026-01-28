class DrugModel {
  final String name;
  final String drugId;

  DrugModel({required this.name, required this.drugId});

  factory DrugModel.fromJson(Map<String, dynamic> json) {
    return DrugModel(
      name: json['name'] as String,
      drugId: json['drugId'] as String,
    );
  }
}
