import 'package:dio/dio.dart';
import 'package:witte_dental_pms/core/constants/api_endpoints.dart';
import 'package:witte_dental_pms/core/services/dio_service.dart';
import 'package:witte_dental_pms/features/shared/widgets/global_widgets.dart';

class AdminPatientRepository {
  AdminPatientRepository() : _apiService = ApiServices();
  final ApiServices _apiService;

   Future<Map<String, dynamic>> addPatient(Map<String, dynamic> patientData) async {
    try {
      dPrint('((((((((((((((((((  Add Patient - Repo )))))))))))))))))))');
      final response = await _apiService.post(ApiEndpoints.baseUrl+ApiEndpoints.storePatient, data: patientData);
      dPrint('(((((((((((((((((( Patient Added Response - Repo )))))))))))))))))))');
      dPrint('Response: ${response.data}');
      dPrint('(((((((((((((((((( Patient Added Response - Repo )))))))))))))))))))');

      if (response.data is Map && response.data['status']==true) {
        return response.data;
      } else {
        throw Exception('Unexpected response format');
      }
    } catch (e) {
      if (e is DioException) {
        dPrint('DioException details: ${e.response?.data}');
      }
      throw Exception('Failed to Add Patient: $e');
    }
  }

   Future<List<dynamic>> getPatientList() async {
    try {
      dPrint('((((((((((((((((((  Get Patient List - Repo )))))))))))))))))))');
      final response = await _apiService.get(ApiEndpoints.baseUrl+ApiEndpoints.getPatientList);
      dPrint('(((((((((((((((((( Patient List Response - Repo )))))))))))))))))))');
      dPrint('Response: ${response.data}');
      dPrint('(((((((((((((((((( Patient List Response - Repo )))))))))))))))))))');

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
      throw Exception('Failed to get Patient List: $e');
    }
  }

  Future<Map<String, dynamic>> updatePatient(Map<String, dynamic> patientData) async {
    try {
      dPrint('((((((((((((((((((  update Patient - Repo )))))))))))))))))))');
      final response = await _apiService.put(ApiEndpoints.baseUrl+ApiEndpoints.updatePatient, data: patientData);
      dPrint('(((((((((((((((((( Patient updated Response - Repo )))))))))))))))))))');
      dPrint('Response: ${response.data}');
      dPrint('(((((((((((((((((( Patient updated Response - Repo )))))))))))))))))))');

      if (response.data is Map && response.data['status']==true) {
        return response.data;
      } else {
        throw Exception('Unexpected response format');
      }
    } catch (e) {
      if (e is DioException) {
        dPrint('DioException details: ${e.response?.data}');
      }
      throw Exception('Failed to update Patient: $e');
    }
  }

  Future<Map<String, dynamic>> deletePatient({
    required String patientId,
  }) async {
    try {
      dPrint('((((((((((((((((((  Delete Patient )))))))))))))))))))');
      dPrint('Patient ID: $patientId');
      dPrint('((((((((((((((((((  Delete Patient )))))))))))))))))))');

      final response = await _apiService.delete(
        ApiEndpoints.baseUrl + ApiEndpoints.deletePatient,
        data: {'id': patientId},
      );
      dPrint('((((((((((((((((((  Response )))))))))))))))))))');
      dPrint('Response: ${response.data}');
      dPrint('((((((((((((((((((  Response )))))))))))))))))))');

      // Directly use response.data as a Map
      if (response.data is Map<String, dynamic>) {
        return response.data;
      } else {
        throw Exception('Unexpected response format');
      }
    } catch (e) {
      if (e is DioException) {
        dPrint('DioException details: ${e.response?.data}');
      }
      throw Exception('Failed to delete patient: $e');
    }
  }
}