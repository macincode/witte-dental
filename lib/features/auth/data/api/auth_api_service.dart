import 'package:dio/dio.dart';
import 'package:witte_dental_pms/core/constants/api_constants.dart';
import 'package:witte_dental_pms/core/services/dio_service.dart';
import 'package:witte_dental_pms/features/auth/data/models/admin_login_response.dart';
import 'package:witte_dental_pms/features/dashboard/data/models/admin_dashboard_response.dart';
import 'package:witte_dental_pms/features/dashboard/data/models/hospital_dashboard_response.dart';

class AuthApiService {
  AuthApiService(this._apiService);
  final ApiServices _apiService;

  // Super Admin Login - /api/superadmin/login
  Future<AdminLoginResponse> superAdminLogin(
      String email, String password) async {
    final response = await _apiService.post(
      ApiEndpoints.superAdminLogin,
      data: {
        'email': email,
        'password': password,
      },
    );
    return AdminLoginResponse.fromJson(response.data);
  }

  // Business Admin Login - /api/admin/login
  Future<AdminLoginResponse> businessAdminLogin(
      String email, String password) async {
    final response = await _apiService.post(
      ApiEndpoints.adminLogin,
      data: {
        'email': email,
        'password': password,
      },
    );
    return AdminLoginResponse.fromJson(response.data);
  }

  // Unified Staff Login - /api/login (Doctor/Staff/Patient)
  Future<AdminLoginResponse> staffLogin(String email, String password) async {
    final response = await _apiService.post(
      ApiEndpoints.staffLogin,
      data: {
        'email': email,
        'password': password,
      },
    );
    return AdminLoginResponse.fromJson(response.data);
  }

  // Admin Dashboard - /api/admin/dashboard
  Future<AdminDashboardResponse> getAdminDashboard(String businessId) async {
    final response = await _apiService.get(
      ApiEndpoints.adminDashboard,
      options: Options(
        headers: {
          'X-Business-ID': businessId,
        },
      ),
    );
    return AdminDashboardResponse.fromJson(response.data);
  }

  // Hospital Dashboard - /api/dashboard/home
  Future<HospitalDashboardResponse> getHospitalDashboard(int hospitalId) async {
    final response = await _apiService.get(
      '${ApiEndpoints.dashboardHome}?hospital_id=$hospitalId',
    );
    return HospitalDashboardResponse.fromJson(response.data);
  }

  Future<void> logout() async {
    await _apiService.post(ApiEndpoints.logout);
  }
}
