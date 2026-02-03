import 'package:witte_dental_pms/core/constants/api_constants.dart';
import 'package:witte_dental_pms/core/services/dio_service.dart';
import 'package:witte_dental_pms/features/auth/data/models/admin_login_response.dart';

class AuthApiService {
  AuthApiService(this._apiService);
  final ApiServices _apiService;

  Future<AdminLoginResponse> adminLogin(String email, String password) async {
    final response = await _apiService.post(
      ApiEndpoints.adminLogin,
      data: {
        'email': email,
        'password': password,
      },
    );
    return AdminLoginResponse.fromJson(response.data);
  }

  // Future<void> regularLogin(String phone, String password) async {
  //   await _apiService.post(
  //     '/login', // Use correct Laravel route
  //     data: {
  //       'phone': phone,
  //       'password': password,
  //     },
  //   );
  // }

  Future<void> logout() async {
    await _apiService.post(ApiEndpoints.logout);
  }
}
