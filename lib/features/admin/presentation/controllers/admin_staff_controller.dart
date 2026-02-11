import 'package:get/get.dart';
import 'package:witte_dental_pms/features/admin/presentation/repositories/admin_staff_repo.dart';
import 'package:witte_dental_pms/features/shared/widgets/global_widgets.dart';


class AdminStaffController extends GetxController {

  final AdminStaffRepository _adminStaffRepository = AdminStaffRepository();
   RxList adminStaffList = [].obs;

   Future<void> addStaffData(Map<String, dynamic> staffData) async {
    try {
      final response = await _adminStaffRepository.addStaff(staffData);
      if (response['status']==true) {
        Get.snackbar(
          'Success',
          'Staff added successfully',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      dPrint('Error fetching tasks: $e');
    } 
  }

  Future<List<dynamic>> getStaffListData() async {
    try {
        dPrint('((((((((((((((((((  Get Staff List - Controller )))))))))))))))))))');
      final response = await _adminStaffRepository.getStaffList();
        dPrint('(((((((((((((((((( Staff List Response - Controller )))))))))))))))))))');
      if (response.isNotEmpty) {
        adminStaffList.assignAll(response);
      dPrint('Response: $adminStaffList');
      dPrint('(((((((((((((((((( Staff List Response - Controller )))))))))))))))))))');
      }
      return response;
    } catch (e) {
      dPrint('Error fetching Staff List: $e');
      return [];
    }
  }

  // Future<void> updateStaffData(Map<String, dynamic> staffData) async {
  //   try {
  //     final response = await _adminStaffRepository.updateStaff(staffData);
  //     if (response['status']==true) {
  //       Get.snackbar(
  //         'Success',
  //         'Staff details updated successfully',
  //         snackPosition: SnackPosition.BOTTOM,
  //       );
  //     }
  //   } catch (e) {
  //     dPrint('Error fetching tasks: $e');
  //   } 
  // }

  // Future<void> deleteStaffData(String staffId) async {
  //   try {
  //     final response = await _adminStaffRepository.deleteStaff(
  //       staffId: staffId,
  //     );
  //     if (response['status'] == true) {
  //       adminStaffList.removeWhere((staff) => staff['id'].toString() == staffId);
  //       Get.snackbar(
  //         'Success',
  //         'Staff deleted successfully',
  //         snackPosition: SnackPosition.BOTTOM,
  //       );
  //     }
  //   } catch (e) {
  //     dPrint('Error deleting staff: $e');
  //     Get.snackbar(
  //       'Error',
  //       'Failed to delete staff',
  //       snackPosition: SnackPosition.BOTTOM,
  //     );
  //   }
  // }

  
}
