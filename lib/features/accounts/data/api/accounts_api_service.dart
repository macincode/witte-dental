import 'package:witte_dental_pms/core/constants/api_constants.dart';
import 'package:witte_dental_pms/core/services/dio_service.dart';

class AccountsApiService {
  AccountsApiService(this._apiService);
  final ApiServices _apiService;

  Future<void> getAccountsList(String fromDate, String toDate) async {
    await _apiService.post(
      ApiEndpoints.getAccountsList,
      data: {
        'from_date': fromDate,
        'to_date': toDate,
      },
    );
  }

  Future<void> addPharmacyAccountEntry(Map<String, dynamic> entryData) async {
    await _apiService.post(
      ApiEndpoints.storePharmacyAccountEntry,
      data: entryData,
    );
  }

  Future<void> addInventoryAccountEntry(Map<String, dynamic> entryData) async {
    await _apiService.post(
      ApiEndpoints.storeInventoryAccountEntry,
      data: entryData,
    );
  }

  Future<void> addLabAccountEntry(Map<String, dynamic> entryData) async {
    await _apiService.post(
      ApiEndpoints.storeLabAccountEntry,
      data: entryData,
    );
  }

  Future<void> getStaffSalary(
    String month,
    String staffId,
    String staffType,
  ) async {
    await _apiService.post(
      ApiEndpoints.getStaffSalary,
      data: {
        'month': month,
        'staff_id': staffId,
        'staff_type': staffType,
      },
    );
  }

  Future<void> addStaffSalary(Map<String, dynamic> salaryData) async {
    await _apiService.post(
      ApiEndpoints.storeStaffSalary,
      data: salaryData,
    );
  }
}
