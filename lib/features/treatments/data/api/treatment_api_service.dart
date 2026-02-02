import 'package:witte_dental_pms/core/constants/api_constants.dart';
import 'package:witte_dental_pms/core/services/dio_service.dart';

class TreatmentApiService {
  TreatmentApiService(this._dioService);
  final DioService _dioService;

  Future<void> getTreatmentList() async {
    await _dioService.get(ApiEndpoints.getTreatmentList);
  }

  Future<void> getCategories() async {
    await _dioService.get(ApiEndpoints.getCategories);
  }

  Future<void> addCategory(String name, String description) async {
    await _dioService.post(
      ApiEndpoints.storeCategory,
      data: {
        'name': name,
        'description': description,
      },
    );
  }

  Future<void> getTreatmentMethods() async {
    await _dioService.get(ApiEndpoints.getTreatmentMethods);
  }

  Future<void> addTreatmentMethod(Map<String, dynamic> methodData) async {
    await _dioService.post(
      ApiEndpoints.storeTreatmentMethod,
      data: methodData,
    );
  }

  Future<void> getMedicalRecords() async {
    await _dioService.get(ApiEndpoints.getMedicalRecords);
  }

  Future<void> addMedicalRecord(Map<String, dynamic> recordData) async {
    await _dioService.post(
      ApiEndpoints.storeMedicalRecord,
      data: recordData,
    );
  }
}
