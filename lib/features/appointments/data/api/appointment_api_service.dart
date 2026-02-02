import 'package:witte_dental_pms/core/constants/api_constants.dart';
import 'package:witte_dental_pms/core/services/dio_service.dart';

class AppointmentApiService {
  AppointmentApiService(this._dioService);
  final DioService _dioService;

  Future<void> getAppointmentList() async {
    await _dioService.get(ApiEndpoints.getAppointmentList);
  }

  Future<void> createAppointment(Map<String, dynamic> appointmentData) async {
    await _dioService.post(
      ApiEndpoints.storeAppointment,
      data: appointmentData,
    );
  }

  Future<void> updateAppointment(Map<String, dynamic> appointmentData) async {
    await _dioService.put(
      ApiEndpoints.updateAppointments,
      data: appointmentData,
    );
  }

  Future<void> updateAppointmentStatus(
    int id,
    String status,
    String completeDate,
  ) async {
    await _dioService.put(
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
    await _dioService.post(
      ApiEndpoints.rescheduleAppointment,
      data: appointmentData,
    );
  }

  Future<void> getUpcomingAppointments() async {
    await _dioService.get(ApiEndpoints.getUpcomingAppointments);
  }

  Future<void> getAppointmentsByDate(String date) async {
    await _dioService.post(
      ApiEndpoints.getAppointmentsByDate,
      data: {'date': date},
    );
  }

  Future<void> addAppointmentSummary(
    Map<String, dynamic> summaryData,
  ) async {
    await _dioService.post(
      ApiEndpoints.addAppointmentSummary,
      data: summaryData,
    );
  }
}
