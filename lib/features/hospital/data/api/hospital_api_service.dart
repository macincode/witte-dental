import 'package:witte_dental_pms/core/constants/api_constants.dart';
import 'package:witte_dental_pms/core/services/dio_service.dart';

class HospitalApiService {
  HospitalApiService(this._apiService);
  final ApiServices _apiService;

  Future<void> getHospitalSettings(int hospitalId) async {
    await _apiService.get(
      ApiEndpoints.getHospitalSettings,
      queryParameters: {'hospital_id': hospitalId},
    );
  }

  Future<void> updatePaymentSettings(Map<String, dynamic> settingsData) async {
    await _apiService.put(
      ApiEndpoints.updatePaymentSettings,
      data: settingsData,
    );
  }

  Future<void> updateWhatsappSettings(Map<String, dynamic> settingsData) async {
    await _apiService.put(
      ApiEndpoints.updateWhatsappSettings,
      data: settingsData,
    );
  }
}
