import 'package:witte_dental_pms/core/constants/api_constants.dart';
import 'package:witte_dental_pms/core/services/dio_service.dart';

class PatientApiService {
  PatientApiService(this._apiService);
  final ApiServices _apiService;

  Future<void> getPatientList() async {
    await _apiService.get(ApiEndpoints.getPatientList);
  }

  Future<void> addPatient(Map<String, dynamic> patientData) async {
    await _apiService.post(
      ApiEndpoints.storePatient,
      data: patientData,
    );
  }

  Future<void> updatePatient(Map<String, dynamic> patientData) async {
    await _apiService.put(
      ApiEndpoints.updatePatient,
      data: patientData,
    );
  }

  Future<void> deletePatient(int id) async {
    await _apiService.delete(
      ApiEndpoints.deletePatient,
      data: {'id': id},
    );
  }
}
