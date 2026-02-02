import 'package:witte_dental_pms/core/constants/api_constants.dart';
import 'package:witte_dental_pms/core/services/dio_service.dart';
import '../models/admin_dashboard_response.dart';
import '../models/hospital_dashboard_response.dart';

class AdminApiService {
  final DioService _dioService;

  AdminApiService(this._dioService);

  Future<AdminDashboardResponse> getAdminDashboard() async {
    final response = await _dioService.get(ApiEndpoints.adminDashboard);
    return AdminDashboardResponse.fromJson(response.data);
  }

  Future<HospitalDashboardResponse> getHospitalDashboard(int hospitalId) async {
    final response = await _dioService.get(
      '${ApiEndpoints.dashboardHome}?hospital_id=$hospitalId',
    );
    return HospitalDashboardResponse.fromJson(response.data);
  }
}
