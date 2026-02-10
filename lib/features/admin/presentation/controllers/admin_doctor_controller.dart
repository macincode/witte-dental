import 'package:get/get.dart';
import 'package:witte_dental_pms/features/admin/presentation/repositories/admin_doctor_repo.dart';
import 'package:witte_dental_pms/features/shared/widgets/global_widgets.dart';


class AdminDoctorController extends GetxController {

  final AdminDoctorRepository _adminDoctorRepository = AdminDoctorRepository();
   RxList adminDoctorList = [].obs;

   Future<void> addDoctorData(Map<String, dynamic> doctorData) async {
    try {
     
      final response = await _adminDoctorRepository.addDoctor(doctorData);
      if (response['status']==true) {
        Get.snackbar(
          'Success',
          'Doctor added successfully',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      dPrint('Error fetching tasks: $e');
    } 
  }
  Future<List<dynamic>> getDoctorListData() async {
    try {
        dPrint('((((((((((((((((((  Get Doctor List - Controller )))))))))))))))))))');
      final response = await _adminDoctorRepository.getDoctorList();
        dPrint('(((((((((((((((((( Doctor List Response - Controller )))))))))))))))))))');
      if (response.isNotEmpty) {
        adminDoctorList.assignAll(response);
      dPrint('Response: $adminDoctorList');
      dPrint('(((((((((((((((((( Doctor List Response - Controller )))))))))))))))))))');
      }
      return response;
    } catch (e) {
      dPrint('Error fetching Doctor List: $e');
      return [];
    }
  }
  Future<void> updateDoctorData(Map<String, dynamic> doctorData) async {
    try {
      final response = await _adminDoctorRepository.updateDoctor(doctorData);
      if (response['status']==true) {
        Get.snackbar(
          'Success',
          'Doctor details updated successfully',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      dPrint('Error fetching tasks: $e');
    } 
  }

  
}
