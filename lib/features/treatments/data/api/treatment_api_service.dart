import 'package:witte_dental_pms/core/constants/api_endpoints.dart';
import 'package:witte_dental_pms/core/services/dio_service.dart';

class TreatmentApiService {
  TreatmentApiService(this._apiService);
  final ApiServices _apiService;

  Future<void> getTreatmentList() async {
    await _apiService.get(ApiEndpoints.getTreatmentList);
  }

  Future<void> getCategories() async {
    await _apiService.get(ApiEndpoints.getCategories);
  }

  Future<void> addCategory(String name, String description) async {
    await _apiService.post(
      ApiEndpoints.storeCategory,
      data: {
        'name': name,
        'description': description,
      },
    );
  }

  Future<void> getTreatmentMethods() async {
    await _apiService.get(ApiEndpoints.getTreatmentMethods);
  }

  Future<void> addTreatmentMethod(Map<String, dynamic> methodData) async {
    await _apiService.post(
      ApiEndpoints.storeTreatmentMethod,
      data: methodData,
    );
  }

  Future<void> getMedicalRecords() async {
    await _apiService.get(ApiEndpoints.getMedicalRecords);
  }

  Future<void> addMedicalRecord(Map<String, dynamic> recordData) async {
    await _apiService.post(
      ApiEndpoints.storeMedicalRecord,
      data: recordData,
    );
  }
}
