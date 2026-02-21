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

class MedicationRepository {
  final MedicationService medicationService;
  MedicationRepository(this.medicationService);

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
    final rawData = await medicationService.getMedicinesDetails(id);
    return rawData.fold(
      (failure) => Left(failure),
      (data) => Right(MedicinesDetailsModel.fromJson(data)),
    );
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
}
