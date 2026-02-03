import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:witte_dental_pms/features/auth/presentation/controllers/auth_controller.dart';
import '../../data/models/hospital_dashboard_response.dart';

class HospitalDashboardController extends GetxController {
  final int hospitalId;

  HospitalDashboardController(this.hospitalId);

  final RxBool _isLoading = false.obs;
  final RxString _errorMessage = ''.obs;
  final Rx<HospitalDashboardData?> _dashboardData =
      Rx<HospitalDashboardData?>(null);

  bool get isLoading => _isLoading.value;
  String get errorMessage => _errorMessage.value;
  HospitalDashboardData? get dashboardData => _dashboardData.value;

  @override
  void onInit() {
    super.onInit();
    // Load data after build is complete
    WidgetsBinding.instance.addPostFrameCallback((_) {
      loadDashboard();
    });
  }

  Future<void> loadDashboard() async {
    try {
      _isLoading.value = true;
      _errorMessage.value = '';

      final authController = Get.find<AuthController>();
      await authController.loadHospitalDashboard(hospitalId);

      if (authController.hospitalDashboard != null) {
        _dashboardData.value = authController.hospitalDashboard!.data;
      }
    } catch (e) {
      _errorMessage.value = 'Failed to load hospital dashboard: $e';
    } finally {
      _isLoading.value = false;
    }
  }

  void clearError() {
    _errorMessage.value = '';
  }
}
