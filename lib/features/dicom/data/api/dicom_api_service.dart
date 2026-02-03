import 'dart:io';

import 'package:dio/dio.dart';
import 'package:witte_dental_pms/core/constants/api_constants.dart';
import 'package:witte_dental_pms/core/services/dio_service.dart';

class DicomApiService {
  DicomApiService(this._apiService);
  final ApiServices _apiService;

  Future<void> uploadDicomFile(
    File dicomFile,
    int patientId,
    String studyDescription,
  ) async {
    final formData = FormData.fromMap({
      'dicom_file': await MultipartFile.fromFile(dicomFile.path),
      'patient_id': patientId,
      'study_description': studyDescription,
    });

    await _apiService.post(
      ApiEndpoints.uploadDicomFile,
      data: formData,
    );
  }

  Future<void> getPatientDicomFiles(int patientId) async {
    await _apiService.get(
      ApiEndpoints.getPatientDicomFiles
          .replaceFirst('{id}', patientId.toString()),
    );
  }

  Future<void> getDicomFileDetails(int fileId) async {
    await _apiService.get(
      ApiEndpoints.getDicomFileDetails.replaceFirst('{id}', fileId.toString()),
    );
  }

  Future<void> saveDicomAnnotations(Map<String, dynamic> annotationData) async {
    await _apiService.post(
      ApiEndpoints.saveDicomAnnotations,
      data: annotationData,
    );
  }
}
