import 'package:dartz/dartz.dart';
import 'package:rafiq/core/errors/failure.dart';
import 'package:rafiq/core/errors/local_failure.dart';
import 'package:rafiq/features/medications/data/models/medicine_object_box_model.dart';
import 'package:rafiq/objectbox.g.dart';
import 'package:rafiq/features/medications/data/data_sources/i_medication_local_data_source.dart';

class MedicationLocalDataSource implements IMedicationLocalDataSource {
  final Box<MedicineObjectBoxModel> medicineBox;

  MedicationLocalDataSource(Store store)
    : medicineBox = store.box<MedicineObjectBoxModel>();

  @override
  Future<Either<Failure, int>> storeMedicineLocally(
    MedicineObjectBoxModel medicine,
  ) async {
    try {
      final id = medicineBox.put(medicine);
      return Right(id);
    } catch (e) {
      return Left(LocalFailure("Failed to store medicine locally: $e"));
    }
  }

  @override
  Future<Either<Failure, List<MedicineObjectBoxModel>>>
  readMedicinesLocally() async {
    try {
      final medicines = medicineBox.getAll();
      return Right(medicines);
    } catch (e) {
      return Left(LocalFailure("Failed to read medicines locally: $e"));
    }
  }

  @override
  Future<Either<Failure, bool>> deleteMedicineLocally(int objectBoxID) async {
    try {
      final deleted = medicineBox.remove(objectBoxID);
      if (deleted) {
        return const Right(true);
      } else {
        return Left(LocalFailure("Medicine with ID $objectBoxID not found"));
      }
    } catch (e) {
      return Left(LocalFailure("Failed to delete medicine locally: $e"));
    }
  }

  @override
  Future<Either<Failure, int>> updateMedicineLocally(
    MedicineObjectBoxModel medicine,
  ) async {
    try {
      // put updates if objectBoxID is set
      final id = medicineBox.put(medicine);
      return Right(id);
    } catch (e) {
      return Left(LocalFailure("Failed to update medicine locally: $e"));
    }
  }
}
