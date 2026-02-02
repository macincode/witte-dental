import 'package:witte_dental_pms/core/constants/api_constants.dart';
import 'package:witte_dental_pms/core/services/dio_service.dart';

class DashboardApiService {
  DashboardApiService(this._dioService);
  final DioService _dioService;

  Future<void> getAdminDashboard() async {
    await _dioService.get(ApiEndpoints.adminDashboard);
  }

  Future<void> getDashboardHome(int hospitalId) async {
    await _dioService.get(
      ApiEndpoints.dashboardHome,
      queryParameters: {'hospital_id': hospitalId},
    );
  }

  Future<void> getCounts() async {
    await _dioService.get(ApiEndpoints.getCounts);
  }
}
