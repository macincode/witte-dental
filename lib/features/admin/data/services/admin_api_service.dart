import 'package:witte_dental_pms/core/constants/api_endpoints.dart';
import 'package:witte_dental_pms/core/services/dio_service.dart';
import 'package:witte_dental_pms/features/shared/widgets/global_widgets.dart';
import '../models/admin_dashboard_response.dart';
import '../models/hospital_dashboard_response.dart';

class AdminApiService {
  AdminApiService(this._apiService);
  final ApiServices _apiService;

  Future<AdminDashboardResponse> getAdminDashboard() async {
    final response = await _apiService.get(ApiEndpoints.adminDashboard);
    dPrint('Raw response data: ${response.data}');
    dPrint('Response data type: ${response.data.runtimeType}');
    return AdminDashboardResponse.fromJson(response.data);
  }

  Future<HospitalDashboardResponse> getHospitalDashboard(int hospitalId) async {
    final response = await _apiService.get(
      '${ApiEndpoints.dashboardHome}?hospital_id=$hospitalId',
    );
    return HospitalDashboardResponse.fromJson(response.data);
  }
}
