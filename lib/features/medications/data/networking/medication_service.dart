import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:rafiq/core/errors/failure.dart';
import 'package:rafiq/core/networking/api_constants.dart';
import 'package:rafiq/core/networking/api_service.dart';
import 'package:rafiq/features/medications/data/models/all_medicines_request.dart';
import 'package:rafiq/features/medications/data/models/medicines_bulk_request.dart';
import 'package:rafiq/features/medications/data/models/medicines_details_request.dart';
import 'package:rafiq/features/medications/data/models/update_medicine_request.dart';

class MedicationService {
  final ApiService _api;
  MedicationService({required ApiService api}) : _api = api;

  Future<Either<Failure, List<dynamic>>> getDrugs(String searchQuery) async {
    try {
      final Response response = await _api.get(
        ApiConstants.drugs,
        queryParameters: {'drug': searchQuery},
      );
      return Right(response.data['content']);
    } catch (e) {
      return Left(e as Failure);
    }
  }

  Future<Either<Failure, dynamic>> getMedicinesDetails(String id) async {
    try {
      final Response response = await _api.get('${ApiConstants.medicine}/$id');
      return Right(response.data);
    } catch (e) {
      return Left(e as Failure);
    }
  }

  Future<Either<Failure, void>> deleteMedicines(String id) async {
    try {
      await _api.delete('${ApiConstants.medicine}/$id');
      return Right(null);
    } catch (e) {
      return Left(e as Failure);
    }
  }

  Future<Either<Failure, dynamic>> addMedicines(
    MedicinesDetailsRequest request,
  ) async {
    try {
      final Response response = await _api.post(
        ApiConstants.medicine,
        data: request.toJson(),
      );
      return Right(response.data['data']);
    } catch (e) {
      return Left(e as Failure);
    }
  }

  Future<Either<Failure, dynamic>> getAllMedicines(
    AllMedicinesRequest request,
  ) async {
    try {
      final Response response = await _api.get(
        ApiConstants.medicine,
        queryParameters: request.toJson(),
      );
      return Right(response.data);
    } catch (e) {
      return Left(e as Failure);
    }
  }

  Future<Either<Failure, dynamic>> updateMedicines(
    String id,
    UpdateMedicineRequest request,
  ) async {
    try {
      final Response response = await _api.patch(
        '${ApiConstants.medicine}/$id',
        data: request.toJson(),
      );
      return Right(response.data['data']);
    } catch (e) {
      return Left(e as Failure);
    }
  }

  Future<Either<Failure, void>> bulkMedicines(
    MedicinesBulkRequest request,
  ) async {
    try {
      await _api.post(ApiConstants.bulkMedicine, data: request.toJson());
      return Right(null);
    } catch (e) {
      return Left(e as Failure);
    }
  }
}
