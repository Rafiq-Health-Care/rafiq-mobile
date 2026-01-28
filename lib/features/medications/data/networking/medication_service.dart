import 'package:dio/dio.dart';
import 'package:rafiq/core/networking/api_constants.dart';
import 'package:rafiq/core/networking/api_service.dart';
import 'package:rafiq/features/medications/data/models/all_medicines_request.dart';
import 'package:rafiq/features/medications/data/models/medicines_bulk_request.dart';
import 'package:rafiq/features/medications/data/models/medicines_details_request.dart';
import 'package:rafiq/features/medications/data/models/update_medicine_request.dart';

class MedicationService {
  final ApiService _api;
  MedicationService({required ApiService api}) : _api = api;

  Future<List<dynamic>> getDrugs(String searchQuery) async {
    try {
      final Response response = await _api.get(
        ApiConstants.drugs,
        queryParameters: {'drug': searchQuery},
      );
      return response.data['content'];
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> getMedicinesDetails(String id) async {
    try {
      final Response response = await _api.get('${ApiConstants.medicines}/$id');
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteMedicines(String id) async {
    try {
      await _api.delete('${ApiConstants.medicines}/$id');
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> addMedicines(MedicinesDetailsRequest request) async {
    try {
      final Response response = await _api.post(
        ApiConstants.addMedicines,
        data: request.toJson(),
      );
      return response.data['data'];
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> getAllMedicines(AllMedicinesRequest request) async {
    try {
      final Response response = await _api.get(
        ApiConstants.medicines,
        queryParameters: request.toJson(),
      );
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> updateMedicines(
    String id,
    UpdateMedicineRequest request,
  ) async {
    try {
      final Response response = await _api.patch(
        '${ApiConstants.medicines}/$id',
        data: request.toJson(),
      );
      return response.data['data'];
    } catch (e) {
      rethrow;
    }
  }

  Future<void> bulkMedicines(MedicinesBulkRequest request) async {
    try {
      await _api.post(ApiConstants.bulkMedicines, data: request.toJson());
    } catch (e) {
      rethrow;
    }
  }
}
