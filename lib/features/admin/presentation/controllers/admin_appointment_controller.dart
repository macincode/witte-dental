import 'package:get/get.dart';
import 'package:witte_dental_pms/features/admin/presentation/repositories/admin_appointment_repo.dart';
import 'package:witte_dental_pms/features/shared/widgets/global_widgets.dart';


class AdminAppointmentController extends GetxController {

  final AdminAppointmentRepository _adminAppointmentRepository = AdminAppointmentRepository();
   RxList adminAppointmentList = [].obs;

   Future<void> addAppointmentData(Map<String, dynamic> appointmentData) async {
    try {
      final response = await _adminAppointmentRepository.addAppointment(appointmentData);
      if (response['status']==true) {
        Get.snackbar(
          'Success',
          'Appointment added successfully',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      dPrint('Error fetching tasks: $e');
    } 
  }

  Future<List<dynamic>> getAppointmentListData() async {
    try {
        dPrint('((((((((((((((((((  Get Appointment List - Controller )))))))))))))))))))');
      final response = await _adminAppointmentRepository.getAppointmentList();
        dPrint('(((((((((((((((((( Appointment List Response - Controller )))))))))))))))))))');
      if (response.isNotEmpty) {
        adminAppointmentList.assignAll(response);
      dPrint('Response: $adminAppointmentList');
      dPrint('(((((((((((((((((( Appointment List Response - Controller )))))))))))))))))))');
      }
      return response;
    } catch (e) {
      dPrint('Error fetching Appointment List: $e');
      return [];
    }
  }

  Future<void> updateAppointmentData(Map<String, dynamic> appointmentData) async {
    try {
      final response = await _adminAppointmentRepository.updateAppointment(appointmentData);
      if (response['status']==true) {
        Get.snackbar(
          'Success',
          'Appointment details updated successfully',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      dPrint('Error fetching tasks: $e');
    } 
  }

  // Future<void> deleteAppointmentData(String appointmentId) async {
  //   try {
  //     final response = await _adminAppointmentRepository.deleteAppointment(
  //       appointmentId: appointmentId,
  //     );
  //     if (response['status'] == true) {
  //       adminAppointmentList.removeWhere((appointment) => appointment['id'].toString() == appointmentId);
  //       Get.snackbar(
  //         'Success',
  //         'Appointment deleted successfully',
  //         snackPosition: SnackPosition.BOTTOM,
  //       );
  //     }
  //   } catch (e) {
  //     dPrint('Error deleting appointment: $e');
  //     Get.snackbar(
  //       'Error',
  //       'Failed to delete appointment',
  //       snackPosition: SnackPosition.BOTTOM,
  //     );
  //   }
  // }

  
}
