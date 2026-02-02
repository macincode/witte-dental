import 'package:witte_dental_pms/core/storage/hive_service.dart';
import 'package:witte_dental_pms/features/auth/data/api/auth_api_service.dart';
import 'package:witte_dental_pms/features/auth/data/models/admin_login_response.dart';

class AuthRepository {
  AuthRepository(this._apiService, this._hiveService);
  final AuthApiService _apiService;
  final HiveService _hiveService;

  Future<AdminLoginResponse> login(String email, String password) async {
    final response = await _apiService.adminLogin(email, password);
    await _hiveService.saveAuthResponse(response);
    return response;
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
