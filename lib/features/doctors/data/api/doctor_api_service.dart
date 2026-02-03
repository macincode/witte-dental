import 'package:witte_dental_pms/core/constants/api_constants.dart';
import 'package:witte_dental_pms/core/services/dio_service.dart';

class DoctorApiService {
  DoctorApiService(this._apiService);
  final ApiServices _apiService;

  Future<void> getDoctorList() async {
    await _apiService.get(ApiEndpoints.getDoctorList);
  }

  Future<void> addDoctor(Map<String, dynamic> doctorData) async {
    await _apiService.post(
      ApiEndpoints.storeDoctor,
      data: doctorData,
    );
  }

  Future<void> updateDoctor(Map<String, dynamic> doctorData) async {
    await _apiService.put(
      ApiEndpoints.updateDoctor,
      data: doctorData,
    );
  }

  Future<void> deleteDoctor(int id, bool isChecked) async {
    await _apiService.delete(
      ApiEndpoints.deleteDoctor,
      data: {
        'id': id,
        'isChecked': isChecked,
      },
    );
  }

  Future<void> getDoctorDepartments() async {
    await _apiService.get(ApiEndpoints.getDoctorDepartments);
  }

  Future<void> addDoctorDepartment(String title, String description) async {
    await _apiService.post(
      ApiEndpoints.addDoctorDepartment,
      data: {
        'title': title,
        'description': description,
      },
    );
  }
}
