import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/models/patient_model.dart';
import '../controllers/patient_list_controller.dart';

class PatientListScreen extends StatelessWidget {
  const PatientListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PatientListController());
    final isDark = Theme.of(context).brightness == Brightness.dark;
    const primaryBlue = Color(0xFF145BD9);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Patients'),
        backgroundColor: isDark ? const Color(0xFF1E1E1E) : Colors.white,
        elevation: 0,
        actions: [
          Obx(
            () => IconButton(
              icon: Icon(
                controller.isGridView.value ? Icons.view_list : Icons.grid_view,
                color: primaryBlue,
              ),
              onPressed: controller.toggleViewMode,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          _buildSearchAndFilters(controller, isDark, primaryBlue),
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return const Center(
                    child: CircularProgressIndicator(color: primaryBlue));
              }

              if (controller.errorMessage.isNotEmpty) {
                return _buildErrorState(controller);
              }

              if (controller.filteredPatients.isEmpty) {
                return const Center(child: Text('No patients found'));
              }

              return controller.isGridView.value
                  ? _buildGridView(controller, isDark)
                  : _buildListView(controller, isDark);
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchAndFilters(
      PatientListController controller, bool isDark, Color primaryBlue) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          TextField(
            onChanged: controller.searchPatients,
            decoration: InputDecoration(
              hintText: 'Search by name or phone...',
              prefixIcon: Icon(Icons.search, color: primaryBlue),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: isDark ? Colors.grey[800] : Colors.grey[100],
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: Obx(
                  () => DropdownButtonFormField<String>(
                    initialValue: controller.selectedGender.value,
                    decoration: InputDecoration(
                      labelText: 'Gender',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: isDark ? Colors.grey[800] : Colors.grey[100],
                    ),
                    items: controller.genderOptions.map((gender) {
                      return DropdownMenuItem(
                        value: gender,
                        child: Text(gender),
                      );
                    }).toList(),
                    onChanged: (value) => controller.filterByGender(value!),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildListView(PatientListController controller, bool isDark) {
    return RefreshIndicator(
      onRefresh: controller.loadPatients,
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: controller.filteredPatients.length,
        itemBuilder: (context, index) {
          final patient = controller.filteredPatients[index];
          return _buildPatientCard(patient, isDark, false);
        },
      ),
    );
  }

  Widget _buildGridView(PatientListController controller, bool isDark) {
    return RefreshIndicator(
      onRefresh: controller.loadPatients,
      child: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 0.8,
        ),
        itemCount: controller.filteredPatients.length,
        itemBuilder: (context, index) {
          final patient = controller.filteredPatients[index];
          return _buildPatientCard(patient, isDark, true);
        },
      ),
    );
  }

  Widget _buildPatientCard(Patient patient, bool isDark, bool isGrid) {
    final cardColor = isDark ? const Color(0xFF1E1E1E) : Colors.white;

    return GestureDetector(
      onTap: () => Get.toNamed('/patient-details', arguments: patient),
      child: Container(
        margin: isGrid ? EdgeInsets.zero : const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: isGrid
            ? _buildGridContent(patient, isDark)
            : _buildListContent(patient, isDark),
      ),
    );
  }

  Widget _buildListContent(Patient patient, bool isDark) {
    return Row(
      children: [
        _buildAvatar(patient, 50),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                patient.fullName,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: isDark ? Colors.white : Colors.black87,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                patient.phone,
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  Icon(
                    patient.gender == 'Male' ? Icons.male : Icons.female,
                    size: 16,
                    color: patient.gender == 'Male' ? Colors.blue : Colors.pink,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '${patient.gender}, ${patient.age} years',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Icon(
          Icons.arrow_forward_ios,
          size: 16,
          color: Colors.grey[400],
        ),
      ],
    );
  }

  Widget _buildGridContent(Patient patient, bool isDark) {
    return Column(
      children: [
        _buildAvatar(patient, 60),
        const SizedBox(height: 12),
        Text(
          patient.fullName,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
            color: isDark ? Colors.white : Colors.black87,
          ),
          textAlign: TextAlign.center,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 4),
        Text(
          patient.phone,
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: patient.gender == 'Male'
                ? Colors.blue.withOpacity(0.1)
                : Colors.pink.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            '${patient.gender}, ${patient.age}',
            style: TextStyle(
              color: patient.gender == 'Male' ? Colors.blue : Colors.pink,
              fontSize: 10,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAvatar(Patient patient, double size) {
    return CircleAvatar(
      radius: size / 2,
      backgroundColor: Colors.grey[300],
      child: patient.image.isNotEmpty
          ? ClipOval(
              child: CachedNetworkImage(
                imageUrl: patient.image,
                width: size,
                height: size,
                fit: BoxFit.cover,
                placeholder: (context, url) =>
                    const CircularProgressIndicator(),
                errorWidget: (context, url, error) => Icon(
                  Icons.person,
                  size: size * 0.6,
                  color: Colors.grey[600],
                ),
              ),
            )
          : Icon(
              Icons.person,
              size: size * 0.6,
              color: Colors.grey[600],
            ),
    );
  }

  Widget _buildErrorState(PatientListController controller) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, size: 48, color: Colors.red),
          const SizedBox(height: 16),
          Text(controller.errorMessage.value),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: controller.loadPatients,
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }
}
