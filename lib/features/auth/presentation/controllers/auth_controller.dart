import 'package:get/get.dart';
import 'package:witte_dental_pms/core/storage/hive_service.dart';
import 'package:witte_dental_pms/features/auth/data/models/admin_login_response.dart';
import 'package:witte_dental_pms/features/auth/data/models/user_model.dart';
import 'package:witte_dental_pms/features/auth/domain/repositories/auth_repository.dart';
import 'package:witte_dental_pms/features/dashboard/data/models/admin_dashboard_response.dart';
import 'package:witte_dental_pms/features/dashboard/data/models/hospital_dashboard_response.dart';
import '../../../../core/constants/app_constants.dart';

class AuthController extends GetxController {
  AuthController(this._authRepository);
  final AuthRepository _authRepository;

  final Rx<AdminLoginResponse?> _authResponse = Rx<AdminLoginResponse?>(null);
  final Rx<AdminDashboardResponse?> _adminDashboard =
      Rx<AdminDashboardResponse?>(null);
  final Rx<HospitalDashboardResponse?> _hospitalDashboard =
      Rx<HospitalDashboardResponse?>(null);
  final RxBool _isLoading = false.obs;
  final RxString _errorMessage = ''.obs;

  User? get currentUser => _authResponse.value?.data;
  dynamic get currentBusiness => _authResponse.value?.currentBusiness;
  dynamic get currentHospital => _authResponse.value?.currentHospital;
  List<dynamic>? get businesses => _authResponse.value?.businesses;
  String? get userType => _authResponse.value?.userType;
  String? get token => _authResponse.value?.token;
  AdminDashboardResponse? get adminDashboard => _adminDashboard.value;
  HospitalDashboardResponse? get hospitalDashboard => _hospitalDashboard.value;
  bool get isLoading => _isLoading.value;
  String get errorMessage => _errorMessage.value;
  bool get isLoggedIn => _authRepository.isLoggedIn();

  void checkAuthStatus() {
    final authResponse = _authRepository.getAuthResponse();
    if (authResponse != null && authResponse.token != null) {
      _authResponse.value = authResponse;
    }
  }

  // Super Admin Login - /api/superadmin/login
  Future<void> superAdminLogin(String email, String password) async {
    try {
      _isLoading.value = true;
      _errorMessage.value = '';

      final response = await _authRepository.superAdminLogin(email, password);

      if (response.success == true) {
        _authResponse.value = response;
        Get.offAllNamed(AppConstants.superAdminDashboard);
      } else {
        _errorMessage.value = response.message;
      }
    } catch (e) {
      _errorMessage.value = 'Super admin login failed: $e';
    } finally {
      _isLoading.value = false;
    }
  }

  // Business Admin Login - /api/admin/login
  Future<void> businessAdminLogin(String email, String password) async {
    try {
      _isLoading.value = true;
      _errorMessage.value = '';

      final response =
          await _authRepository.businessAdminLogin(email, password);

      if (response.success == true) {
        _authResponse.value = response;
        Get.offAllNamed(AppConstants.adminHomeScreen);
      } else {
        _errorMessage.value = response.message;
      }
    } catch (e) {
      _errorMessage.value = 'Business admin login failed: $e';
    } finally {
      _isLoading.value = false;
    }
  }

  // Unified Staff Login - /api/login (Doctor/Staff/Patient)
  Future<void> staffLogin(String email, String password) async {
    try {
      _isLoading.value = true;
      _errorMessage.value = '';

      final response = await _authRepository.staffLogin(email, password);

      if (response.status == true || response.success == true) {
        _authResponse.value = response;
        navigateBasedOnUserType(response.userType);
      } else {
        _errorMessage.value = response.message ?? 'Login failed';
      }
    } catch (e) {
      _errorMessage.value = 'Staff login failed: $e';
    } finally {
      _isLoading.value = false;
    }
  }

  // Load Admin Dashboard
  Future<void> loadAdminDashboard() async {
    try {
      _isLoading.value = true;
      final businessId = _getBusinessId();
      final response = await _authRepository.getAdminDashboard(businessId);
      _adminDashboard.value = response;
    } catch (e) {
      _errorMessage.value = 'Failed to load admin dashboard: $e';
    } finally {
      _isLoading.value = false;
    }
  }

  String _getBusinessId() {
    if (currentBusiness != null && currentBusiness['id'] != null) {
      return currentBusiness['id'].toString();
    }
    return '1'; // Default fallback
  }

  // Load Hospital Dashboard
  Future<void> loadHospitalDashboard(int hospitalId) async {
    try {
      _isLoading.value = true;
      final response = await _authRepository.getHospitalDashboard(hospitalId);
      _hospitalDashboard.value = response;
    } catch (e) {
      _errorMessage.value = 'Failed to load hospital dashboard: $e';
    } finally {
      _isLoading.value = false;
    }
  }

  void navigateBasedOnUserType(String? userType) {
    switch (userType) {
      case 'doctor':
        Get.offAllNamed(AppConstants.doctorDashboard);
        break;
      case 'staff':
        Get.offAllNamed(AppConstants.staffDashboard);
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
        return 'superadmin';
      case 2:
        return 'admin';
      case 3:
        return 'doctor';
      case 4:
        return 'staff';
      case 5:
        return 'patient';
      default:
        return 'user';
    }
  }

  Future<void> logout() async {
    try {
      _isLoading.value = true;
      // Call logout API
      await _authRepository.logout();
      await HiveService.clearAllData();
    } catch (e) {
      // Continue with local logout even if API fails
    } finally {
      // Clear local data
      _authResponse.value = null;
      _adminDashboard.value = null;
      _hospitalDashboard.value = null;
      _isLoading.value = false;
      // Navigate to login
      Get.offAllNamed(AppConstants.loginRoute);
    }
  }

  void clearError() {
    _errorMessage.value = '';
  }
}
