import 'package:witte_dental_pms/core/constants/api_constants.dart';
import 'package:witte_dental_pms/core/services/dio_service.dart';

class NotificationsApiService {
  NotificationsApiService(this._dioService);
  final DioService _dioService;

  Future<void> getNotifications(String role, int id) async {
    await _dioService.post(
      ApiEndpoints.getNotifications,
      data: {
        'role': role,
        'id': id,
      },
    );
  }

  Future<void> changeNotificationStatus(
    String role,
    int id,
    int notificationId,
  ) async {
    await _dioService.post(
      ApiEndpoints.changeNotificationStatus,
      data: {
        'role': role,
        'id': id,
        'notification_id': notificationId,
      },
    );
  }

  Future<void> storeEnquiry(Map<String, dynamic> enquiryData) async {
    await _dioService.post(
      ApiEndpoints.storeEnquiry,
      data: enquiryData,
    );
  }

  Future<void> getEnquiryList(String role, int id) async {
    await _dioService.post(
      ApiEndpoints.getEnquiryList,
      data: {
        'role': role,
        'id': id,
      },
    );
  }
}
