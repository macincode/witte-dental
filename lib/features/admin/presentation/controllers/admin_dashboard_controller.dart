import 'package:get/get.dart';
import '../../data/models/admin_dashboard_response.dart';
import '../../data/models/hospital_dashboard_response.dart';
import '../../data/services/admin_api_service.dart';

class AdminDashboardController extends GetxController {
  final AdminApiService _apiService;

  AdminDashboardController(this._apiService);

  final RxBool _isLoading = false.obs;
  final RxString _errorMessage = ''.obs;
  final Rx<AdminDashboardData?> _dashboardData = Rx<AdminDashboardData?>(null);
  final Rx<HospitalDashboardData?> _hospitalData =
      Rx<HospitalDashboardData?>(null);
  final RxInt _selectedHospitalId = 1.obs;

  bool get isLoading => _isLoading.value;
  String get errorMessage => _errorMessage.value;
  AdminDashboardData? get dashboardData => _dashboardData.value;
  HospitalDashboardData? get hospitalData => _hospitalData.value;
  int get selectedHospitalId => _selectedHospitalId.value;

  @override
  void onInit() {
    super.onInit();
    loadDashboard();
  }

  Future<void> loadDashboard() async {
    try {
      _isLoading.value = true;
      _errorMessage.value = '';

      final response = await _apiService.getAdminDashboard();
      if (response.success) {
        _dashboardData.value = response.data;
        // Load first hospital data by default
        if (response.data.hospitals.isNotEmpty) {
          _selectedHospitalId.value = response.data.hospitals.first.id;
          await loadHospitalData(_selectedHospitalId.value);
        }
      }
    } catch (e) {
      _errorMessage.value = 'Failed to load dashboard: $e';
    } finally {
      _isLoading.value = false;
    }
  }

  Future<void> loadHospitalData(int hospitalId) async {
    try {
      _selectedHospitalId.value = hospitalId;
      final response = await _apiService.getHospitalDashboard(hospitalId);
      if (response.status) {
        _hospitalData.value = response.data;
      }
    } catch (e) {
      _errorMessage.value = 'Failed to load hospital data: $e';
    }
  }

  void clearError() {
    _errorMessage.value = '';
  }
}
