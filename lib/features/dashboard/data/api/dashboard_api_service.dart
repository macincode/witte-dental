import 'package:witte_dental_pms/core/constants/api_constants.dart';
import 'package:witte_dental_pms/core/services/dio_service.dart';

class DashboardApiService {
  DashboardApiService(this._apiService);
  final ApiServices _apiService;

  Future<void> getAdminDashboard() async {
    await _apiService.get(ApiEndpoints.adminDashboard);
  }

  Future<void> getDashboardHome(int hospitalId) async {
    await _apiService.get(
      ApiEndpoints.dashboardHome,
      queryParameters: {'hospital_id': hospitalId},
    );
  }

  Future<void> getCounts() async {
    await _apiService.get(ApiEndpoints.getCounts);
  }
}
