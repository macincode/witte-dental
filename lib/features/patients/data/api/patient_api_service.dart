import 'package:witte_dental_pms/core/constants/api_constants.dart';
import 'package:witte_dental_pms/core/services/dio_service.dart';
import '../models/patient_model.dart';

class PatientApiService {
  PatientApiService(this._apiService);
  final ApiServices _apiService;

  Future<PatientListResponse> getPatientList() async {
    final response = await _apiService.get(ApiEndpoints.getPatientList);
    return PatientListResponse.fromJson(response.data);
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
