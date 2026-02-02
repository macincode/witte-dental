import 'package:witte_dental_pms/core/constants/api_constants.dart';
import 'package:witte_dental_pms/core/services/dio_service.dart';

class StaffApiService {
  StaffApiService(this._dioService);
  final DioService _dioService;

  Future<void> getStaffList() async {
    await _dioService.get(ApiEndpoints.getStaffList);
  }

  Future<void> addStaff(Map<String, dynamic> staffData) async {
    await _dioService.post(
      ApiEndpoints.storeStaff,
      data: staffData,
    );
  }

  Future<void> getStaffCategories() async {
    await _dioService.get(ApiEndpoints.getStaffCategories);
  }

  Future<void> addStaffCategory(String name, String description) async {
    await _dioService.post(
      ApiEndpoints.storeStaffCategory,
      data: {
        'name': name,
        'description': description,
      },
    );
  }
}
