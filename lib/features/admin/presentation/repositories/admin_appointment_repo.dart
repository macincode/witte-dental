import 'package:dio/dio.dart';
import 'package:witte_dental_pms/core/constants/api_endpoints.dart';
import 'package:witte_dental_pms/core/services/dio_service.dart';
import 'package:witte_dental_pms/features/shared/widgets/global_widgets.dart';

class AdminAppointmentRepository {
  AdminAppointmentRepository() : _apiService = ApiServices();
  final ApiServices _apiService;

   Future<Map<String, dynamic>> addAppointment(Map<String, dynamic> appointmentData) async {
    try {
      dPrint('((((((((((((((((((  Add Appointment - Repo )))))))))))))))))))');
      final response = await _apiService.post(ApiEndpoints.baseUrl+ApiEndpoints.storeAppointment, data: appointmentData);
      dPrint('(((((((((((((((((( Appointment Added Response - Repo )))))))))))))))))))');
      dPrint('Response: ${response.data}');
      dPrint('(((((((((((((((((( Appointment Added Response - Repo )))))))))))))))))))');

      if (response.data is Map && response.data['status']==true) {
        return response.data;
      } else {
        throw Exception('Unexpected response format');
      }
    } catch (e) {
      if (e is DioException) {
        dPrint('DioException details: ${e.response?.data}');
      }
      throw Exception('Failed to Add Appointment: $e');
    }
  }

   Future<List<dynamic>> getAppointmentList() async {
    try {
      dPrint('((((((((((((((((((  Get Appointment List - Repo )))))))))))))))))))');
      final response = await _apiService.get(ApiEndpoints.baseUrl+ApiEndpoints.getAppointmentList);
      dPrint('(((((((((((((((((( Appointment List Response - Repo )))))))))))))))))))');
      dPrint('Response: ${response.data}');
      dPrint('(((((((((((((((((( Appointment List Response - Repo )))))))))))))))))))');

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
      throw Exception('Failed to get Appointment List: $e');
    }
  }

  Future<Map<String, dynamic>> updateAppointment(Map<String, dynamic> appointmentData) async {
    try {
      dPrint('((((((((((((((((((  update Appointment - Repo )))))))))))))))))))');
      final response = await _apiService.put(ApiEndpoints.baseUrl+ApiEndpoints.updateAppointments, data: appointmentData);
      dPrint('(((((((((((((((((( Appointment updated Response - Repo )))))))))))))))))))');
      dPrint('Response: ${response.data}');
      dPrint('(((((((((((((((((( Appointment updated Response - Repo )))))))))))))))))))');

      if (response.data is Map && response.data['status']==true) {
        return response.data;
      } else {
        throw Exception('Unexpected response format');
      }
    } catch (e) {
      if (e is DioException) {
        dPrint('DioException details: ${e.response?.data}');
      }
      throw Exception('Failed to update Appointment: $e');
    }
  }
}