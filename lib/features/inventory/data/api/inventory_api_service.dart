import 'package:witte_dental_pms/core/constants/api_constants.dart';
import 'package:witte_dental_pms/core/services/dio_service.dart';

class InventoryApiService {
  InventoryApiService(this._dioService);
  final DioService _dioService;

  Future<void> getInventoryList() async {
    await _dioService.get(ApiEndpoints.getInventoryList);
  }

  Future<void> addInventoryItem(Map<String, dynamic> itemData) async {
    await _dioService.post(
      ApiEndpoints.storeInventoryItem,
      data: itemData,
    );
  }

  Future<void> getInventoryCategories() async {
    await _dioService.get(ApiEndpoints.getInventoryCategories);
  }
}
