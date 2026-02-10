import 'package:dio/dio.dart';
import 'package:witte_dental_pms/core/constants/api_endpoints.dart';
import 'package:witte_dental_pms/core/services/dio_service.dart';
import 'package:witte_dental_pms/features/shared/widgets/global_widgets.dart';

class AdminDoctorRepository {
  AdminDoctorRepository() : _apiService = ApiServices();
  final ApiServices _apiService;

   Future<Map<String, dynamic>> addDoctor(Map<String, dynamic> doctorData) async {
    try {
      dPrint('((((((((((((((((((  Add Doctor - Repo )))))))))))))))))))');
      final response = await _apiService.post(ApiEndpoints.baseUrl+ApiEndpoints.storeDoctor, data: doctorData);
      dPrint('(((((((((((((((((( Doctor Added Response - Repo )))))))))))))))))))');
      dPrint('Response: ${response.data}');
      dPrint('(((((((((((((((((( Doctor Added Response - Repo )))))))))))))))))))');

      if (response.data is Map && response.data['status']==true) {
        return response.data;
      } else {
        throw Exception('Unexpected response format');
      }
    } catch (e) {
      if (e is DioException) {
        dPrint('DioException details: ${e.response?.data}');
      }
      throw Exception('Failed to Add Doctor: $e');
    }
  }

   Future<List<dynamic>> getDoctorList() async {
    try {
      dPrint('((((((((((((((((((  Get Doctor List - Repo )))))))))))))))))))');
      final response = await _apiService.get(ApiEndpoints.baseUrl+ApiEndpoints.getDoctorList);
      dPrint('(((((((((((((((((( Doctor List Response - Repo )))))))))))))))))))');
      dPrint('Response: ${response.data}');
      dPrint('(((((((((((((((((( Doctor List Response - Repo )))))))))))))))))))');

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
      throw Exception('Failed to get Doctor List: $e');
    }
  }

  Future<Map<String, dynamic>> updateDoctor(Map<String, dynamic> doctorData) async {
    try {
      dPrint('((((((((((((((((((  update Doctor - Repo )))))))))))))))))))');
      final response = await _apiService.put(ApiEndpoints.baseUrl+ApiEndpoints.updateDoctor, data: doctorData);
      dPrint('(((((((((((((((((( Doctor updated Response - Repo )))))))))))))))))))');
      dPrint('Response: ${response.data}');
      dPrint('(((((((((((((((((( Doctor updated Response - Repo )))))))))))))))))))');

      if (response.data is Map && response.data['status']==true) {
        return response.data;
      } else {
        throw Exception('Unexpected response format');
      }
    } catch (e) {
      if (e is DioException) {
        dPrint('DioException details: ${e.response?.data}');
      }
      throw Exception('Failed to update Doctor: $e');
    }
  }
}