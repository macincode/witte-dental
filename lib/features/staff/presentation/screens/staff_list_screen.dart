import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/models/staff_model.dart';
import '../controllers/staff_list_controller.dart';

class StaffListScreen extends StatelessWidget {
  const StaffListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(StaffListController());
    final isDark = Theme.of(context).brightness == Brightness.dark;
    const primaryBlue = Color(0xFF145BD9);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Staff'),
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

              if (controller.filteredStaff.isEmpty) {
                return const Center(child: Text('No staff found'));
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
      StaffListController controller, bool isDark, Color primaryBlue) {
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
            onChanged: controller.searchStaff,
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
              const SizedBox(width: 12),
              Expanded(
                child: Obx(
                  () => DropdownButtonFormField<String>(
                    initialValue: controller.selectedCategory.value,
                    decoration: InputDecoration(
                      labelText: 'Category',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: isDark ? Colors.grey[800] : Colors.grey[100],
                    ),
                    items: controller.categoryOptions.map((category) {
                      return DropdownMenuItem(
                        value: category,
                        child: Text(category),
                      );
                    }).toList(),
                    onChanged: (value) => controller.filterByCategory(value!),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildListView(StaffListController controller, bool isDark) {
    return RefreshIndicator(
      onRefresh: controller.loadStaff,
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: controller.filteredStaff.length,
        itemBuilder: (context, index) {
          final staff = controller.filteredStaff[index];
          return _buildStaffCard(staff, isDark, false);
        },
      ),
    );
  }

  Widget _buildGridView(StaffListController controller, bool isDark) {
    return RefreshIndicator(
      onRefresh: controller.loadStaff,
      child: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 0.75,
        ),
        itemCount: controller.filteredStaff.length,
        itemBuilder: (context, index) {
          final staff = controller.filteredStaff[index];
          return _buildStaffCard(staff, isDark, true);
        },
      ),
    );
  }

  Widget _buildStaffCard(Staff staff, bool isDark, bool isGrid) {
    final cardColor = isDark ? const Color(0xFF1E1E1E) : Colors.white;

    return GestureDetector(
      onTap: () => Get.toNamed('/staff-details', arguments: staff),
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
            ? _buildGridContent(staff, isDark)
            : _buildListContent(staff, isDark),
      ),
    );
  }

  Widget _buildListContent(Staff staff, bool isDark) {
    return Row(
      children: [
        _buildAvatar(staff, 50),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                staff.fullName,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: isDark ? Colors.white : Colors.black87,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                staff.staffCategory,
                style: const TextStyle(
                  color: Color(0xFF145BD9),
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                staff.phone,
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  Icon(
                    staff.gender == 'Male' ? Icons.male : Icons.female,
                    size: 16,
                    color: staff.gender == 'Male' ? Colors.blue : Colors.pink,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '${staff.gender}, ${staff.age} years',
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

  Widget _buildGridContent(Staff staff, bool isDark) {
    return Column(
      children: [
        _buildAvatar(staff, 60),
        const SizedBox(height: 12),
        Text(
          staff.fullName,
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
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: const Color(0xFF145BD9).withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            staff.staffCategory,
            style: const TextStyle(
              color: Color(0xFF145BD9),
              fontSize: 10,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          staff.phone,
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: staff.gender == 'Male'
                ? Colors.blue.withOpacity(0.1)
                : Colors.pink.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            '${staff.gender}, ${staff.age}',
            style: TextStyle(
              color: staff.gender == 'Male' ? Colors.blue : Colors.pink,
              fontSize: 10,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAvatar(Staff staff, double size) {
    return CircleAvatar(
      radius: size / 2,
      backgroundColor: Colors.grey[300],
      child: staff.image.isNotEmpty
          ? ClipOval(
              child: CachedNetworkImage(
                imageUrl: staff.image,
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

  Widget _buildErrorState(StaffListController controller) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, size: 48, color: Colors.red),
          const SizedBox(height: 16),
          Text(controller.errorMessage.value),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: controller.loadStaff,
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }
}
