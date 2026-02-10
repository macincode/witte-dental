import 'package:get/get.dart';
import 'package:witte_dental_pms/features/admin/presentation/repositories/admin_patient_repo.dart';
import 'package:witte_dental_pms/features/shared/widgets/global_widgets.dart';


class AdminPatientController extends GetxController {

  final AdminPatientRepository _adminPatientRepository = AdminPatientRepository();
   RxList adminPatientList = [].obs;

   Future<void> addPatientData(Map<String, dynamic> patientData) async {
    try {
      final response = await _adminPatientRepository.addPatient(patientData);
      if (response['status']==true) {
        Get.snackbar(
          'Success',
          'Patient added successfully',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      dPrint('Error fetching tasks: $e');
    } 
  }

  Future<List<dynamic>> getPatientListData() async {
    try {
        dPrint('((((((((((((((((((  Get Patient List - Controller )))))))))))))))))))');
      final response = await _adminPatientRepository.getPatientList();
        dPrint('(((((((((((((((((( Patient List Response - Controller )))))))))))))))))))');
      if (response.isNotEmpty) {
        adminPatientList.assignAll(response);
      dPrint('Response: $adminPatientList');
      dPrint('(((((((((((((((((( Patient List Response - Controller )))))))))))))))))))');
      }
      return response;
    } catch (e) {
      dPrint('Error fetching Patient List: $e');
      return [];
    }
  }

  Future<void> updatePatientData(Map<String, dynamic> patientData) async {
    try {
      final response = await _adminPatientRepository.updatePatient(patientData);
      if (response['status']==true) {
        Get.snackbar(
          'Success',
          'Patient details updated successfully',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      dPrint('Error fetching tasks: $e');
    } 
  }

  Future<void> deletePatientData(String patientId) async {
    try {
      final response = await _adminPatientRepository.deletePatient(
        patientId: patientId,
      );
      if (response['status'] == true) {
        adminPatientList.removeWhere((patient) => patient['id'].toString() == patientId);
        Get.snackbar(
          'Success',
          'Patient deleted successfully',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      dPrint('Error deleting patient: $e');
      Get.snackbar(
        'Error',
        'Failed to delete patient',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  
}
