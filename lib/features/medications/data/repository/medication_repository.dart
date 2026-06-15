import 'package:dartz/dartz.dart';
import 'package:rafiq/core/errors/failure.dart';
import 'package:rafiq/features/medications/data/models/all_medicines_content_model.dart';
import 'package:rafiq/features/medications/data/models/all_medicines_request.dart';
import 'package:rafiq/features/medications/data/models/all_medicines_response.dart';
import 'package:rafiq/features/medications/data/models/drug_model.dart';
import 'package:rafiq/features/medications/data/models/medicines_bulk_request.dart';
import 'package:rafiq/features/medications/data/models/medicines_details_model.dart';
import 'package:rafiq/features/medications/data/models/medicines_details_request.dart';
import 'package:rafiq/features/medications/data/models/update_medicine_request.dart';
import 'package:rafiq/features/medications/data/networking/medication_service.dart';
import 'package:rafiq/features/medications/data/models/medicine_object_box_model.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:rafiq/core/services/i_notification_service.dart';
import 'package:rafiq/features/medications/data/data_sources/i_medication_local_data_source.dart';
import 'package:rafiq/core/errors/local_failure.dart';

class MedicationRepository {
  final MedicationService medicationService;
  final IMedicationLocalDataSource medicationLocalDataSource;
  final INotificationService notificationService;
  final InternetConnectionChecker internetConnectionChecker;

  MedicationRepository({
    required this.medicationService,
    required this.medicationLocalDataSource,
    required this.notificationService,
    required this.internetConnectionChecker,
  });

  Future<Either<Failure, List<DrugModel>>> getDrugs(String searchQuery) async {
    final rawData = await medicationService.getDrugs(searchQuery);
    return rawData.fold(
      (failure) => Left(failure),
      (drugs) => Right(drugs.map((drug) => DrugModel.fromJson(drug)).toList()),
    );
  }

  Future<Either<Failure, MedicinesDetailsModel>> getMedicinesDetails(
    String id,
  ) async {
    if (await internetConnectionChecker.hasConnection) {
      final rawData = await medicationService.getMedicinesDetails(id);
      return rawData.fold(
        (failure) => Left(failure),
        (data) => Right(MedicinesDetailsModel.fromJson(data)),
      );
    } else {
      final localData = await medicationLocalDataSource.readMedicinesLocally();
      return localData.fold((failure) => Left(failure), (medicines) {
        final medicine = medicines.where((e) => e.id == id).firstOrNull;
        if (medicine == null) {
          return Left(LocalFailure('Medicine not found locally'));
        }
        return Right(medicine.toMedicinesDetailsModel());
      });
    }
  }

  Future<Either<Failure, void>> deleteMedicines(String id) async {
    final rawData = await medicationService.deleteMedicines(id);
    return rawData.fold((failure) => Left(failure), (data) => Right(null));
  }

  Future<Either<Failure, AllMedicinesContentModel>> addMedicines(
    MedicinesDetailsRequest request,
  ) async {
    final rawData = await medicationService.addMedicines(request);
    return rawData.fold(
      (failure) => Left(failure),
      (data) => Right(AllMedicinesContentModel.fromJson(data)),
    );
  }

  Future<Either<Failure, AllMedicinesResponse>> getAllMedicines(
    AllMedicinesRequest request,
  ) async {
    final rawData = await medicationService.getAllMedicines(request);
    return rawData.fold(
      (failure) => Left(failure),
      (data) => Right(AllMedicinesResponse.fromJson(data)),
    );
  }

  Future<Either<Failure, MedicinesDetailsModel>> updateMedicines(
    String id,
    UpdateMedicineRequest request,
  ) async {
    final rawData = await medicationService.updateMedicines(id, request);
    return rawData.fold(
      (failure) => Left(failure),
      (data) => Right(MedicinesDetailsModel.fromJson(data)),
    );
  }

  Future<Either<Failure, void>> bulkMedicines(
    MedicinesBulkRequest request,
  ) async {
    final rawData = await medicationService.bulkMedicines(request);
    return rawData.fold((failure) => Left(failure), (data) => Right(null));
  }

  // Local CRUD operations
  Future<Either<Failure, int>> storeMedicineLocally(
    MedicineObjectBoxModel medicine,
  ) async {
    final result = await medicationLocalDataSource.storeMedicineLocally(
      medicine,
    );
    return result.fold((failure) => Left(failure), (id) {
      notificationService.scheduleMedicineNotifications(medicine);
      return Right(id);
    });
  }

  Future<Either<Failure, List<MedicineObjectBoxModel>>>
  readMedicinesLocally() async {
    return await medicationLocalDataSource.readMedicinesLocally();
  }

  Future<Either<Failure, bool>> deleteMedicineLocally(
    MedicineObjectBoxModel medicine,
  ) async {
    await notificationService.cancelMedicineNotifications(medicine);
    return await medicationLocalDataSource.deleteMedicineLocally(
      medicine.objectBoxID,
    );
  }

  Future<Either<Failure, int>> updateMedicineLocally(
    MedicineObjectBoxModel medicine,
  ) async {
    final oldMedicines = await readMedicinesLocally();
    final result = await medicationLocalDataSource.updateMedicineLocally(
      medicine,
    );
    return result.fold((failure) => Left(failure), (id) async {
      await oldMedicines.fold((_) {}, (oldMedicines) async {
        try {
          final oldMedicine = oldMedicines.firstWhere(
            (e) => e.id == medicine.id,
          );
          await notificationService.cancelMedicineNotifications(oldMedicine);
        } catch (_) {}
      });
      await notificationService.scheduleMedicineNotifications(medicine);
      return Right(id);
    });
  }
}
