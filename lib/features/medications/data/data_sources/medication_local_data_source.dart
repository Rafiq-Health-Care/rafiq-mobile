import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:rafiq/core/errors/failure.dart';
import 'package:rafiq/core/errors/local_failure.dart';
import 'package:rafiq/features/medications/data/models/medicine_object_box_model.dart';
import 'package:rafiq/features/medications/data/models/medicine_entity.dart';
import 'package:rafiq/core/services/session_manager.dart';
import 'package:rafiq/core/services/medication_encryption_service.dart';
import 'package:rafiq/objectbox.g.dart';
import 'package:rafiq/features/medications/data/data_sources/i_medication_local_data_source.dart';

class MedicationLocalDataSource implements IMedicationLocalDataSource {
  final Box<MedicineEntity> medicineBox;
  final MedicationEncryptionService encryptionService;

  MedicationLocalDataSource(Store store)
    : medicineBox = store.box<MedicineEntity>(),
      encryptionService = MedicationEncryptionService();

  Future<String> _getActiveUserEmail() async {
    return await SessionManager.getCurrentUserEmail() ?? 'default_user';
  }

  @override
  Future<Either<Failure, int>> storeMedicineLocally(
    MedicineObjectBoxModel medicine,
  ) async {
    try {
      final email = await _getActiveUserEmail();
      final jsonString = json.encode(medicine.toJson());
      final encryptedData = await encryptionService.encrypt(jsonString, email);

      final entity = MedicineEntity(
        objectBoxID: medicine.objectBoxID,
        apiId: medicine.id,
        userEmail: email,
        status: medicine.status,
        encryptedData: encryptedData,
      );

      final id = medicineBox.put(entity);
      return Right(id);
    } catch (e) {
      return Left(LocalFailure("Failed to store medicine locally: $e"));
    }
  }

  @override
  Future<Either<Failure, List<MedicineObjectBoxModel>>>
  readMedicinesLocally() async {
    try {
      final email = await _getActiveUserEmail();
      // Only get entities for the current user
      final entities = medicineBox
          .query(MedicineEntity_.userEmail.equals(email))
          .build()
          .find();

      final medicines = <MedicineObjectBoxModel>[];
      for (final entity in entities) {
        try {
          final decryptedJsonString = await encryptionService.decrypt(entity.encryptedData, email);
          final decryptedMap = json.decode(decryptedJsonString) as Map<String, dynamic>;
          medicines.add(
            MedicineObjectBoxModel.fromJson(
              decryptedMap,
              objectBoxID: entity.objectBoxID,
              id: entity.apiId,
              status: entity.status,
            ),
          );
        } catch (e) {
          // Skip records that fail decryption (e.g. key mismatches or corruption)
          continue;
        }
      }
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
      final email = await _getActiveUserEmail();
      final jsonString = json.encode(medicine.toJson());
      final encryptedData = await encryptionService.encrypt(jsonString, email);

      final entity = MedicineEntity(
        objectBoxID: medicine.objectBoxID,
        apiId: medicine.id,
        userEmail: email,
        status: medicine.status,
        encryptedData: encryptedData,
      );

      final id = medicineBox.put(entity);
      return Right(id);
    } catch (e) {
      return Left(LocalFailure("Failed to update medicine locally: $e"));
    }
  }
}
