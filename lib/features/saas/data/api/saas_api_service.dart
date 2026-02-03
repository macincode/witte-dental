import 'package:witte_dental_pms/core/constants/api_constants.dart';
import 'package:witte_dental_pms/core/services/dio_service.dart';

class SaasApiService {
  SaasApiService(this._apiService);
  final ApiServices _apiService;

  Future<void> getSaasPlans() async {
    await _apiService.get(ApiEndpoints.getSaasPlans);
  }

  Future<void> createSaasPlan(Map<String, dynamic> planData) async {
    await _apiService.post(
      ApiEndpoints.createSaasPlan,
      data: planData,
    );
  }

  Future<void> getBusinessProfile() async {
    await _apiService.get(ApiEndpoints.getBusinessProfile);
  }

  Future<void> updateBusinessProfile(Map<String, dynamic> profileData) async {
    await _apiService.put(
      ApiEndpoints.updateBusinessProfile,
      data: profileData,
    );
  }

  Future<void> getAvailableHospitals() async {
    await _apiService.get(ApiEndpoints.getAvailableHospitals);
  }

  Future<void> switchHospitalContext(int hospitalId) async {
    await _apiService.post(
      ApiEndpoints.switchHospitalContext,
      data: {'hospital_id': hospitalId},
    );
  }
}
