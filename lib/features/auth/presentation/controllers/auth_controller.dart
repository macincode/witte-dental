import 'package:get/get.dart';
import 'package:witte_dental_pms/core/storage/hive_service.dart';
import 'package:witte_dental_pms/features/auth/data/models/admin_login_response.dart';
import 'package:witte_dental_pms/features/auth/data/models/business_model.dart';
import 'package:witte_dental_pms/features/auth/data/models/hospital_model.dart';
import 'package:witte_dental_pms/features/auth/data/models/user_model.dart';
import 'package:witte_dental_pms/features/auth/domain/repositories/auth_repository.dart';
import '../../../../core/constants/app_constants.dart';

class AuthController extends GetxController {
  AuthController(this._authRepository);
  final AuthRepository _authRepository;

  final Rx<AdminLoginResponse?> _authResponse = Rx<AdminLoginResponse?>(null);
  final RxBool _isLoading = false.obs;
  final RxString _errorMessage = ''.obs;

  User? get currentUser => _authResponse.value?.data;
  Business? get currentBusiness => _authResponse.value?.currentBusiness;
  Hospital? get currentHospital => _authResponse.value?.currentHospital;
  List<Business>? get businesses => _authResponse.value?.businesses;
  String? get userType => _authResponse.value?.userType;
  String? get token => _authResponse.value?.token;
  bool get isLoading => _isLoading.value;
  String get errorMessage => _errorMessage.value;
  bool get isLoggedIn => _authRepository.isLoggedIn();

  void checkAuthStatus() {
    if (isLoggedIn) {
      final authResponse = _authRepository.getAuthResponse();
      if (authResponse != null) {
        _authResponse.value = authResponse;
        // Don't auto-navigate on checkAuthStatus, let the caller decide
      }
    }
  }

  Future<void> login(String email, String password) async {
    try {
      _isLoading.value = true;
      _errorMessage.value = '';

      final response = await _authRepository.login(email, password);

      if (response.success) {
        _authResponse.value = response;
        navigateBasedOnRole(response.userType);
      } else {
        _errorMessage.value = response.message;
      }
    } catch (e) {
      _errorMessage.value = 'Login failed: $e';
    } finally {
      _isLoading.value = false;
    }
  }

  void navigateBasedOnRole(String? userType) {
    switch (userType) {
      case 'admin':
        Get.offAllNamed(AppConstants.adminHomeScreen);
        break;
      case 'doctor':
        Get.offAllNamed(AppConstants.doctorDashboard);
        break;
      case 'patient':
        Get.offAllNamed(AppConstants.patientDashboard);
        break;
      default:
        Get.offAllNamed(AppConstants.loginRoute);
    }
  }

  String getRoleFromRoleId(int roleId) {
    switch (roleId) {
      case 1:
        return AppConstants.rolePatient;
      case 2:
        return AppConstants.roleAdmin;
      case 3:
        return AppConstants.roleDoctor;
      case 4:
        return AppConstants.roleStaff;
      default:
        return 'user';
    }
  }

  Future<void> logout() async {
    try {
      _isLoading.value = true;
      await _authRepository.logout();
      await HiveService.clearAllData();
      _authResponse.value = null;
      await Get.offAllNamed(AppConstants.loginRoute);
    } finally {
      _isLoading.value = false;
    }
  }

  void clearError() {
    _errorMessage.value = '';
  }
}
