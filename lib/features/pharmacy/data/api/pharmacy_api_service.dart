import 'package:witte_dental_pms/core/constants/api_constants.dart';
import 'package:witte_dental_pms/core/services/dio_service.dart';

class PharmacyApiService {
  PharmacyApiService(this._dioService);
  final DioService _dioService;

  Future<void> getPharmacyList() async {
    await _dioService.get(ApiEndpoints.getPharmacyList);
  }

  Future<void> addPharmacyItem(Map<String, dynamic> itemData) async {
    await _dioService.post(
      ApiEndpoints.storePharmacyItem,
      data: itemData,
    );
  }

  Future<void> updatePharmacyItem(Map<String, dynamic> itemData) async {
    await _dioService.put(
      ApiEndpoints.updatePharmacyItem,
      data: itemData,
    );
  }

  Future<void> deletePharmacyItem(int id) async {
    await _dioService.delete(
      ApiEndpoints.deletePharmacyItem,
      data: {'id': id},
    );
  }

  Future<void> getPharmacyCategories() async {
    await _dioService.get(ApiEndpoints.getPharmacyCategories);
  }

  Future<void> addPharmacyCategory(String name, String description) async {
    await _dioService.post(
      ApiEndpoints.storePharmacyCategory,
      data: {
        'name': name,
        'description': description,
      },
    );
  }
}
