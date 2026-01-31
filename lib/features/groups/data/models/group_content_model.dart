import 'package:equatable/equatable.dart';
import 'package:rafiq/features/medications/data/models/all_medicines_content_model.dart';

class GroupContentModel extends Equatable {
  final String id;
  final String patientId;
  final String name;
  final String description;
  final String color;
  final String? iconUrl;
  final int medicineCount;
  final List<AllMedicinesContentModel> medicines;
  final DateTime createdAt;
  final DateTime updatedAt;

  const GroupContentModel({
    required this.id,
    required this.patientId,
    required this.name,
    required this.description,
    required this.color,
    this.iconUrl,
    required this.medicineCount,
    required this.medicines,
    required this.createdAt,
    required this.updatedAt,
  });

  factory GroupContentModel.fromJson(Map<String, dynamic> json) {
    return GroupContentModel(
      id: json['id'],
      patientId: json['patientId'],
      name: json['name'],
      description: json['description'],
      color: json['color'],
      iconUrl: json['iconUrl'],
      medicineCount: json['medicineCount'],
      medicines: List<AllMedicinesContentModel>.from(
        json['medicines'].map((x) => AllMedicinesContentModel.fromJson(x)),
      ),
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  GroupContentModel copyWith({
    String? id,
    String? patientId,
    String? name,
    String? description,
    String? color,
    String? iconUrl,
    int? medicineCount,
    List<AllMedicinesContentModel>? medicines,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return GroupContentModel(
      id: id ?? this.id,
      patientId: patientId ?? this.patientId,
      name: name ?? this.name,
      description: description ?? this.description,
      color: color ?? this.color,
      iconUrl: iconUrl ?? this.iconUrl,
      medicineCount: medicineCount ?? this.medicineCount,
      medicines: medicines ?? this.medicines,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props => [
    id,
    patientId,
    name,
    description,
    color,
    iconUrl,
    medicineCount,
    medicines,
    createdAt,
    updatedAt,
  ];
}
