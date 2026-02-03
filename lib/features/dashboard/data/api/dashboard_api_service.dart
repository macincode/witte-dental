import 'package:witte_dental_pms/core/constants/api_constants.dart';
import 'package:witte_dental_pms/core/services/dio_service.dart';
import 'package:witte_dental_pms/features/dashboard/data/models/admin_dashboard_response.dart';
import 'package:witte_dental_pms/features/dashboard/data/models/hospital_dashboard_response.dart';

class DashboardApiService {
  DashboardApiService(this._apiService);
  final ApiServices _apiService;

  Future<AdminDashboardResponse> getAdminDashboard() async {
    final response = await _apiService.get(
      ApiEndpoints.adminDashboard,
      headers: {
        'X-Business-ID': '1', // This should come from auth state
      },
    );
    return AdminDashboardResponse.fromJson(response.data);
  }

  Future<HospitalDashboardResponse> getHospitalDashboard(int hospitalId) async {
    final response = await _apiService.get(
      '${ApiEndpoints.dashboardHome}?hospital_id=$hospitalId',
    );
    return HospitalDashboardResponse.fromJson(response.data);
  }
}
