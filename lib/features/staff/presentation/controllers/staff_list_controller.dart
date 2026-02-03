import 'package:get/get.dart';

import '../../../../core/services/dio_service.dart';
import '../../data/api/staff_api_service.dart';
import '../../data/models/staff_model.dart';

class StaffListController extends GetxController {
  final StaffApiService _apiService = StaffApiService(Get.find<ApiServices>());

  final RxList<Staff> staff = <Staff>[].obs;
  final RxList<Staff> filteredStaff = <Staff>[].obs;
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;
  final RxString searchQuery = ''.obs;
  final RxString selectedGender = 'All'.obs;
  final RxString selectedCategory = 'All'.obs;
  final RxBool isGridView = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadStaff();
  }

  Future<void> loadStaff() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final response = await _apiService.getStaffList();
      staff.value = response.data;
      applyFilters();
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  void searchStaff(String query) {
    searchQuery.value = query;
    applyFilters();
  }

  void filterByGender(String gender) {
    selectedGender.value = gender;
    applyFilters();
  }

  void filterByCategory(String category) {
    selectedCategory.value = category;
    applyFilters();
  }

  void toggleViewMode() {
    isGridView.value = !isGridView.value;
  }

  void applyFilters() {
    final filtered = staff.where((staffMember) {
      final matchesSearch = searchQuery.value.isEmpty ||
          staffMember.fullName
              .toLowerCase()
              .contains(searchQuery.value.toLowerCase()) ||
          staffMember.phone.contains(searchQuery.value);

      final matchesGender = selectedGender.value == 'All' ||
          staffMember.gender == selectedGender.value;

      final matchesCategory = selectedCategory.value == 'All' ||
          staffMember.staffCategory == selectedCategory.value;

      return matchesSearch && matchesGender && matchesCategory;
    }).toList();

    filteredStaff.value = filtered;
  }

  List<String> get genderOptions => ['All', 'Male', 'Female'];

  List<String> get categoryOptions {
    final categories = staff.map((s) => s.staffCategory).toSet().toList();
    return ['All', ...categories];
  }
}
