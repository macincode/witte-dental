import 'package:witte_dental_pms/core/constants/api_endpoints.dart';
import 'package:witte_dental_pms/core/services/dio_service.dart';

class AppointmentApiService {
  AppointmentApiService(this._apiService);
  final ApiServices _apiService;

  Future<void> getAppointmentList() async {
    await _apiService.get(ApiEndpoints.getAppointmentList);
  }

  Future<void> createAppointment(Map<String, dynamic> appointmentData) async {
    await _apiService.post(
      ApiEndpoints.storeAppointment,
      data: appointmentData,
    );
  }

  Future<void> updateAppointment(Map<String, dynamic> appointmentData) async {
    await _apiService.put(
      ApiEndpoints.updateAppointments,
      data: appointmentData,
    );
  }

  Future<void> updateAppointmentStatus(
    int id,
    String status,
    String completeDate,
  ) async {
    await _apiService.put(
      ApiEndpoints.appointmentStatusUpdate,
      data: {
        'id': id,
        'appointment_status': status,
        'complete_date': completeDate,
      },
    );
  }

  Future<void> rescheduleAppointment(
    Map<String, dynamic> appointmentData,
  ) async {
    await _apiService.post(
      ApiEndpoints.rescheduleAppointment,
      data: appointmentData,
    );
  }

  Future<void> getUpcomingAppointments() async {
    await _apiService.get(ApiEndpoints.getUpcomingAppointments);
  }

  Future<void> getAppointmentsByDate(String date) async {
    await _apiService.post(
      ApiEndpoints.getAppointmentsByDate,
      data: {'date': date},
    );
  }

  Future<void> addAppointmentSummary(
    Map<String, dynamic> summaryData,
  ) async {
    await _apiService.post(
      ApiEndpoints.addAppointmentSummary,
      data: summaryData,
    );
  }
}
