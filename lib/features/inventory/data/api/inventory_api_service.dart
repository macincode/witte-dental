import 'package:witte_dental_pms/core/constants/api_constants.dart';
import 'package:witte_dental_pms/core/services/dio_service.dart';

class InventoryApiService {
  InventoryApiService(this._apiService);
  final ApiServices _apiService;

  Future<void> getInventoryList() async {
    await _apiService.get(ApiEndpoints.getInventoryList);
  }

  Future<void> addInventoryItem(Map<String, dynamic> itemData) async {
    await _apiService.post(
      ApiEndpoints.storeInventoryItem,
      data: itemData,
    );
  }

  Future<void> getInventoryCategories() async {
    await _apiService.get(ApiEndpoints.getInventoryCategories);
  }
}
