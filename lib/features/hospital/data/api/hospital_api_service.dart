import 'package:witte_dental_pms/core/constants/api_constants.dart';
import 'package:witte_dental_pms/core/services/dio_service.dart';

class HospitalApiService {
  HospitalApiService(this._dioService);
  final DioService _dioService;

  Future<void> getHospitalSettings(int hospitalId) async {
    await _dioService.get(
      ApiEndpoints.getHospitalSettings,
      queryParameters: {'hospital_id': hospitalId},
    );
  }

  Future<void> updatePaymentSettings(Map<String, dynamic> settingsData) async {
    await _dioService.put(
      ApiEndpoints.updatePaymentSettings,
      data: settingsData,
    );
  }

  Future<void> updateWhatsappSettings(Map<String, dynamic> settingsData) async {
    await _dioService.put(
      ApiEndpoints.updateWhatsappSettings,
      data: settingsData,
    );
  }
}
