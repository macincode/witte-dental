import 'package:witte_dental_pms/core/constants/api_constants.dart';
import 'package:witte_dental_pms/core/services/dio_service.dart';

class PatientApiService {
  PatientApiService(this._dioService);
  final DioService _dioService;

  Future<void> getPatientList() async {
    await _dioService.get(ApiEndpoints.getPatientList);
  }

  Future<void> addPatient(Map<String, dynamic> patientData) async {
    await _dioService.post(
      ApiEndpoints.storePatient,
      data: patientData,
    );
  }

  Future<void> updatePatient(Map<String, dynamic> patientData) async {
    await _dioService.put(
      ApiEndpoints.updatePatient,
      data: patientData,
    );
  }

  Future<void> deletePatient(int id) async {
    await _dioService.delete(
      ApiEndpoints.deletePatient,
      data: {'id': id},
    );
  }
}
