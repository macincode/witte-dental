import 'package:get/get.dart';

import '../../../../core/services/dio_service.dart';
import '../../data/api/patient_api_service.dart';
import '../../data/models/patient_model.dart';

class PatientListController extends GetxController {
  final PatientApiService _apiService =
      PatientApiService(Get.find<ApiServices>());

  final RxList<Patient> patients = <Patient>[].obs;
  final RxList<Patient> filteredPatients = <Patient>[].obs;
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;
  final RxString searchQuery = ''.obs;
  final RxString selectedGender = 'All'.obs;
  final RxBool isGridView = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadPatients();
  }

  Future<void> loadPatients() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final response = await _apiService.getPatientList();
      patients.value = response.data;
      applyFilters();
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  void searchPatients(String query) {
    searchQuery.value = query;
    applyFilters();
  }

  void filterByGender(String gender) {
    selectedGender.value = gender;
    applyFilters();
  }

  void toggleViewMode() {
    isGridView.value = !isGridView.value;
  }

  void applyFilters() {
    final filtered = patients.where((patient) {
      final matchesSearch = searchQuery.value.isEmpty ||
          patient.fullName
              .toLowerCase()
              .contains(searchQuery.value.toLowerCase()) ||
          patient.phone.contains(searchQuery.value);

      final matchesGender = selectedGender.value == 'All' ||
          patient.gender == selectedGender.value;

      return matchesSearch && matchesGender;
    }).toList();

    filteredPatients.value = filtered;
  }

  List<String> get genderOptions => ['All', 'Male', 'Female'];
}
