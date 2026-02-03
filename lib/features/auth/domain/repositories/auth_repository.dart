import 'package:witte_dental_pms/core/storage/hive_service.dart';
import 'package:witte_dental_pms/features/auth/data/api/auth_api_service.dart';
import 'package:witte_dental_pms/features/auth/data/models/admin_login_response.dart';
import 'package:witte_dental_pms/features/dashboard/data/models/admin_dashboard_response.dart';
import 'package:witte_dental_pms/features/dashboard/data/models/hospital_dashboard_response.dart';

class AuthRepository {
  AuthRepository(this._apiService, this._hiveService);
  final AuthApiService _apiService;
  final HiveService _hiveService;

  // Super Admin Login
  Future<AdminLoginResponse> superAdminLogin(
    String email,
    String password,
  ) async {
    final response = await _apiService.superAdminLogin(email, password);
    await _hiveService.saveAuthResponse(response);
    return response;
  }

  // Business Admin Login
  Future<AdminLoginResponse> businessAdminLogin(
    String email,
    String password,
  ) async {
    final response = await _apiService.businessAdminLogin(email, password);
    await _hiveService.saveAuthResponse(response);
    return response;
  }

  // Unified Staff Login (Doctor/Staff/Patient)
  Future<AdminLoginResponse> staffLogin(String email, String password) async {
    final response = await _apiService.staffLogin(email, password);
    await _hiveService.saveAuthResponse(response);
    return response;
  }

  // Admin Dashboard
  Future<AdminDashboardResponse> getAdminDashboard(String businessId) async {
    return _apiService.getAdminDashboard(businessId);
  }

  // Hospital Dashboard
  Future<HospitalDashboardResponse> getHospitalDashboard(int hospitalId) async {
    return _apiService.getHospitalDashboard(hospitalId);
  }

  Future<void> logout() async {
    try {
      await _apiService.logout();
    } catch (e) {
      // Continue with local logout even if API call fails
    }
    await _hiveService.clearAuthBox();
  }

  bool isLoggedIn() {
    final authResponse = _hiveService.getAuthResponse();
    return authResponse != null && authResponse.token != null;
  }

  AdminLoginResponse? getAuthResponse() {
    return _hiveService.getAuthResponse();
  }
}
