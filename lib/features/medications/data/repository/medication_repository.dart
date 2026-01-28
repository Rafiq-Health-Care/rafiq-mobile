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

  Future<List<DrugModel>> getDrugs(String searchQuery) async {
    final rawData = await medicationService.getDrugs(searchQuery);
    return rawData.map((drug) => DrugModel.fromJson(drug)).toList();
  }

  Future<MedicinesDetailsModel> getMedicinesDetails(String id) async {
    final rawData = await medicationService.getMedicinesDetails(id);
    return MedicinesDetailsModel.fromJson(rawData);
  }

  Future<void> deleteMedicines(String id) async {
    await medicationService.deleteMedicines(id);
  }

  Future<AllMedicinesContentModel> addMedicines(
    MedicinesDetailsRequest request,
  ) async {
    final rawData = await medicationService.addMedicines(request);
    return AllMedicinesContentModel.fromJson(rawData);
  }

  Future<AllMedicinesResponse> getAllMedicines(
    AllMedicinesRequest request,
  ) async {
    final rawData = await medicationService.getAllMedicines(request);
    return AllMedicinesResponse.fromJson(rawData);
  }

  Future<MedicinesDetailsModel> updateMedicines(
    String id,
    UpdateMedicineRequest request,
  ) async {
    final rawData = await medicationService.updateMedicines(id, request);
    return MedicinesDetailsModel.fromJson(rawData);
  }

  Future<void> bulkMedicines(MedicinesBulkRequest request) async {
    await medicationService.bulkMedicines(request);
  }
}
