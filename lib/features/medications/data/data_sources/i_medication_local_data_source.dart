import 'package:dartz/dartz.dart';
import 'package:rafiq/core/errors/failure.dart';
import 'package:rafiq/features/medications/data/models/medicine_object_box_model.dart';

abstract class IMedicationLocalDataSource {
  Future<Either<Failure, int>> storeMedicineLocally(
    MedicineObjectBoxModel medicine,
  );
  Future<Either<Failure, List<MedicineObjectBoxModel>>> readMedicinesLocally();
  Future<Either<Failure, bool>> deleteMedicineLocally(int objectBoxID);
  Future<Either<Failure, int>> updateMedicineLocally(
    MedicineObjectBoxModel medicine,
  );
}
