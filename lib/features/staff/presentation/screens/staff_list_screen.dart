import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:witte_dental_pms/features/staff/presentation/controllers/staff_list_controller.dart';

class StaffListScreen extends StatelessWidget {
  const StaffListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // START: Controller Binding
    // Replace with your actual controller: final controller = Get.find<StaffController>();
    final controller = Get.put(StaffListController());
    // END: Controller Binding

    final isDark = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor =
        isDark ? const Color(0xFF121212) : const Color(0xFFF8F9FD);

    return Scaffold(
      backgroundColor: backgroundColor,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          _buildAppBar(context, isDark),

          // Search & Filter Header
          SliverToBoxAdapter(
            child: Obx(
              () => _SearchFilterHeader(
                onSearch: controller.search,
                onFilterTap: () => controller.showFilterDialog(context),
                onToggleView: controller.toggleView,
                isGridView: controller.isGridView.value,
              ),
            ),
          ),

          // Staff List Content
          Obx(() {
            if (controller.isLoading.value) {
              return const SliverFillRemaining(
                  child: Center(child: CircularProgressIndicator()));
            }

            // Replace 'filteredStaff' with your actual list variable
            if (controller.filteredStaff.isEmpty) {
              return SliverFillRemaining(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.people_outline,
                          size: 48, color: Colors.grey[400]),
                      const SizedBox(height: 16),
                      Text('No staff members found',
                          style: TextStyle(color: Colors.grey[500])),
                    ],
                  ),
                ),
              );
            }

            return SliverPadding(
              padding: const EdgeInsets.all(20),
              sliver: controller.isGridView.value
                  ? _buildListView(context, controller.filteredStaff, isDark)
                  : _buildGridView(context, controller.filteredStaff, isDark),
            );
          }),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // TODO: Navigate to Add Staff Screen
        },
        backgroundColor: const Color(0xFF145BD9),
        elevation: 4,
        icon: const Icon(Icons.add, color: Colors.white),
        label: const Text('Add Staff',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );
  }

  // --- AppBar ---
  Widget _buildAppBar(BuildContext context, bool isDark) {
    return SliverAppBar(
      floating: true,
      pinned: true,
      elevation: 0,
      backgroundColor: isDark ? const Color(0xFF1E1E1E) : Colors.white,
      iconTheme: IconThemeData(color: isDark ? Colors.white : Colors.black87),
      title: Text(
        'Staff Directory',
        style: TextStyle(
          color: isDark ? Colors.white : Colors.black87,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  // --- List View Mode ---
  Widget _buildListView(
      BuildContext context, List<dynamic> staffList, bool isDark) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          final staff = staffList[index];
          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                if (!isDark)
                  BoxShadow(
                      color: Colors.grey.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 4)),
              ],
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(16),
                onTap: () {
                  Get.toNamed('/staff-details', arguments: staff);
                },
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      // Avatar
                      _buildAvatar(staff.image, 56),
                      const SizedBox(width: 16),

                      // Info
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              staff.fullName,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: isDark ? Colors.white : Colors.black87,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              staff.staffCategory,
                              style: const TextStyle(
                                fontSize: 13,
                                color: Color(0xFF145BD9),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                Icon(Icons.phone_outlined,
                                    size: 12, color: Colors.grey[500]),
                                const SizedBox(width: 4),
                                Text(
                                  staff.phone,
                                  style: TextStyle(
                                      color: Colors.grey[500], fontSize: 12),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      // Arrow
                      Icon(Icons.arrow_forward_ios_rounded,
                          size: 16, color: Colors.grey[400]),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
        childCount: staffList.length,
      ),
    );
  }

  // --- Grid View Mode ---
  Widget _buildGridView(
      BuildContext context, List<dynamic> staffList, bool isDark) {
    return SliverGrid(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.8,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          final staff = staffList[index];
          return DecoratedBox(
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                if (!isDark)
                  BoxShadow(
                      color: Colors.grey.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 4)),
              ],
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(20),
                onTap: () {
                  Get.toNamed('/staff-details', arguments: staff);
                },
                child: Column(
                  children: [
                    // Image section (60% height)
                    Expanded(
                      flex: 6,
                      child: Container(
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          ),
                        ),
                        child: ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          ),
                          child: staff.image != null && staff.image!.isNotEmpty
                              ? CachedNetworkImage(
                                  imageUrl: staff.image!,
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) => Container(
                                    color: Colors.grey[200],
                                    child: const Icon(Icons.person,
                                        size: 40, color: Colors.grey),
                                  ),
                                  errorWidget: (context, url, error) =>
                                      Container(
                                    color: Colors.grey[200],
                                    child: const Icon(Icons.person,
                                        size: 40, color: Colors.grey),
                                  ),
                                )
                              : Container(
                                  color: Colors.grey[200],
                                  child: const Icon(Icons.person,
                                      size: 40, color: Colors.grey),
                                ),
                        ),
                      ),
                    ),
                    // Content section (40% height)
                    Expanded(
                      flex: 4,
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              staff.fullName,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: isDark ? Colors.white : Colors.black87,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              'Staff ID: #${staff.id}',
                              style: TextStyle(
                                fontSize: 10,
                                color: Colors.grey[600],
                              ),
                            ),
                            const SizedBox(height: 6),
                            // Info chips row
                            Row(
                              children: [
                                _buildInfoChip(staff.staffCategory, Icons.work,
                                    Colors.blue),
                                const SizedBox(width: 4),
                                _buildInfoChip(
                                    staff.gender[0], Icons.wc, Colors.purple),
                              ],
                            ),
                            const SizedBox(height: 6),
                            Text(
                              staff.phone ?? 'No Phone',
                              style: TextStyle(
                                fontSize: 11,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
        childCount: staffList.length,
      ),
    );
  }

  // --- Helper Widgets ---

  Widget _buildInfoChip(String text, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 8, color: color),
          const SizedBox(width: 2),
          Text(
            text,
            style: TextStyle(
              fontSize: 8,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAvatar(String? url, double size) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.grey.withOpacity(0.1)),
      ),
      child: ClipOval(
        child: url != null && url.isNotEmpty
            ? CachedNetworkImage(
                imageUrl: url,
                fit: BoxFit.cover,
                placeholder: (context, url) =>
                    Container(color: Colors.grey[200]),
                errorWidget: (context, url, error) => _buildFallbackAvatar(),
              )
            : _buildFallbackAvatar(),
      ),
    );
  }

  Widget _buildFallbackAvatar() {
    return ColoredBox(
      color: const Color(0xFF145BD9).withOpacity(0.05),
      child: const Icon(Icons.person, color: Color(0xFF145BD9)),
    );
  }
}

// --- Internal Search Header Component ---
class _SearchFilterHeader extends StatelessWidget {
  const _SearchFilterHeader({
    required this.onSearch,
    required this.onFilterTap,
    required this.onToggleView,
    required this.isGridView,
  });
  final Function(String) onSearch;
  final VoidCallback onFilterTap;
  final VoidCallback onToggleView;
  final bool isGridView;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardColor = isDark ? const Color(0xFF1E1E1E) : Colors.white;

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 48,
              decoration: BoxDecoration(
                color: cardColor,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  if (!isDark)
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 4)),
                ],
              ),
              child: TextField(
                onChanged: onSearch,
                style: TextStyle(color: isDark ? Colors.white : Colors.black87),
                decoration: InputDecoration(
                  hintText: 'Search staff...',
                  hintStyle: TextStyle(color: Colors.grey[500], fontSize: 14),
                  prefixIcon:
                      Icon(Icons.search_rounded, color: Colors.grey[400]),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(vertical: 14),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          _buildActionButton(
            icon: Icons.filter_list_rounded,
            onTap: onFilterTap,
            isDark: isDark,
            bgColor: cardColor,
          ),
          const SizedBox(width: 8),
          _buildActionButton(
            icon:
                isGridView ? Icons.view_list_rounded : Icons.grid_view_rounded,
            onTap: onToggleView,
            isDark: isDark,
            bgColor: cardColor,
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required VoidCallback onTap,
    required bool isDark,
    required Color bgColor,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        height: 48,
        width: 48,
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            if (!isDark)
              BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 4)),
          ],
        ),
        child: Icon(icon,
            color: isDark ? Colors.white : const Color(0xFF145BD9), size: 22),
      ),
    );
  }
}
