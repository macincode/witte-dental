import 'package:dio/dio.dart';
import 'package:witte_dental_pms/core/constants/api_endpoints.dart';
import 'package:witte_dental_pms/core/services/dio_service.dart';
import 'package:witte_dental_pms/features/shared/widgets/global_widgets.dart';

class AdminStaffRepository {
  AdminStaffRepository() : _apiService = ApiServices();
  final ApiServices _apiService;

   Future<Map<String, dynamic>> addStaff(Map<String, dynamic> staffData) async {
    try {
      dPrint('((((((((((((((((((  Add Staff - Repo )))))))))))))))))))');
      final response = await _apiService.post(ApiEndpoints.baseUrl+ApiEndpoints.storeStaff, data: staffData);
      dPrint('(((((((((((((((((( Staff Added Response - Repo )))))))))))))))))))');
      dPrint('Response: ${response.data}');
      dPrint('(((((((((((((((((( Staff Added Response - Repo )))))))))))))))))))');

      if (response.data is Map && response.data['status']==true) {
        return response.data;
      } else {
        throw Exception('Unexpected response format');
      }
    } catch (e) {
      if (e is DioException) {
        dPrint('DioException details: ${e.response?.data}');
      }
      throw Exception('Failed to Add Staff: $e');
    }
  }

   Future<List<dynamic>> getStaffList() async {
    try {
      dPrint('((((((((((((((((((  Get Staff List - Repo )))))))))))))))))))');
      final response = await _apiService.get(ApiEndpoints.baseUrl+ApiEndpoints.getStaffList);
      dPrint('(((((((((((((((((( Staff List Response - Repo )))))))))))))))))))');
      dPrint('Response: ${response.data}');
      dPrint('(((((((((((((((((( Staff List Response - Repo )))))))))))))))))))');

      // Check if response.data is a Map with 'data' key
      if (response.data is Map && response.data['data'] is List) {
        return response.data['data'];
      } else {
        throw Exception('Unexpected response format');
      }
    } catch (e) {
      if (e is DioException) {
        dPrint('DioException details: ${e.response?.data}');
      }
      throw Exception('Failed to get Staff List: $e');
    }
  }

  // Future<Map<String, dynamic>> updateStaff(Map<String, dynamic> staffData) async {
  //   try {
  //     dPrint('((((((((((((((((((  update Staff - Repo )))))))))))))))))))');
  //     final response = await _apiService.put(ApiEndpoints.baseUrl+ApiEndpoints.updateStaff, data: staffData);
  //     dPrint('(((((((((((((((((( Staff updated Response - Repo )))))))))))))))))))');
  //     dPrint('Response: ${response.data}');
  //     dPrint('(((((((((((((((((( Staff updated Response - Repo )))))))))))))))))))');

  //     if (response.data is Map && response.data['status']==true) {
  //       return response.data;
  //     } else {
  //       throw Exception('Unexpected response format');
  //     }
  //   } catch (e) {
  //     if (e is DioException) {
  //       dPrint('DioException details: ${e.response?.data}');
  //     }
  //     throw Exception('Failed to update Staff: $e');
  //   }
  // }
}