import 'package:witte_dental_pms/core/constants/api_constants.dart';
import 'package:witte_dental_pms/core/services/dio_service.dart';

class StaffApiService {
  StaffApiService(this._apiService);
  final ApiServices _apiService;

  Future<void> getStaffList() async {
    await _apiService.get(ApiEndpoints.getStaffList);
  }

  Future<void> addStaff(Map<String, dynamic> staffData) async {
    await _apiService.post(
      ApiEndpoints.storeStaff,
      data: staffData,
    );
  }

  Future<void> getStaffCategories() async {
    await _apiService.get(ApiEndpoints.getStaffCategories);
  }

  Future<void> addStaffCategory(String name, String description) async {
    await _apiService.post(
      ApiEndpoints.storeStaffCategory,
      data: {
        'name': name,
        'description': description,
      },
    );
  }
}
