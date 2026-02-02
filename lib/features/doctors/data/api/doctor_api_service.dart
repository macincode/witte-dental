import 'package:witte_dental_pms/core/constants/api_constants.dart';
import 'package:witte_dental_pms/core/services/dio_service.dart';

class DoctorApiService {
  DoctorApiService(this._dioService);
  final DioService _dioService;

  Future<void> getDoctorList() async {
    await _dioService.get(ApiEndpoints.getDoctorList);
  }

  Future<void> addDoctor(Map<String, dynamic> doctorData) async {
    await _dioService.post(
      ApiEndpoints.storeDoctor,
      data: doctorData,
    );
  }

  Future<void> updateDoctor(Map<String, dynamic> doctorData) async {
    await _dioService.put(
      ApiEndpoints.updateDoctor,
      data: doctorData,
    );
  }

  Future<void> deleteDoctor(int id, bool isChecked) async {
    await _dioService.delete(
      ApiEndpoints.deleteDoctor,
      data: {
        'id': id,
        'isChecked': isChecked,
      },
    );
  }

  Future<void> getDoctorDepartments() async {
    await _dioService.get(ApiEndpoints.getDoctorDepartments);
  }

  Future<void> addDoctorDepartment(String title, String description) async {
    await _dioService.post(
      ApiEndpoints.addDoctorDepartment,
      data: {
        'title': title,
        'description': description,
      },
    );
  }
}
