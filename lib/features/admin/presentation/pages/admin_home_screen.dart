import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:witte_dental_pms/core/controllers/language_controller.dart';
import 'package:witte_dental_pms/core/controllers/theme_controller.dart';
import 'package:witte_dental_pms/features/admin/presentation/controllers/admin_dashboard_controller.dart';
import 'package:witte_dental_pms/features/auth/presentation/controllers/auth_controller.dart';
import 'package:witte_dental_pms/features/dashboard/presentation/screens/hospital_dashboard_screen.dart';
import 'package:witte_dental_pms/features/shared/widgets/network_aware_widget.dart';
import 'package:witte_dental_pms/features/shared/widgets/role_based_drawer.dart';

class AdminHomeScreen extends StatefulWidget {
  const AdminHomeScreen({super.key});

  @override
  State<AdminHomeScreen> createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  final themeController = Get.find<ThemeController>();
  final authController = Get.find<AuthController>();
  late AdminDashboardController _controller;
  DateTime? _lastBackPressed;

  IconData _getThemeIcon(AppThemeMode mode) {
    switch (mode) {
      case AppThemeMode.light:
        return Icons.light_mode;
      case AppThemeMode.dark:
        return Icons.dark_mode;
      case AppThemeMode.system:
        return Icons.settings_suggest;
    }
  }

  @override
  void initState() {
    super.initState();
    _controller = Get.put(AdminDashboardController(Get.find()));
    // Load data after build is complete
    WidgetsBinding.instance.addPostFrameCallback((_) {
      authController.loadAdminDashboard();
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: NetworkAwareWidget(
        child: Scaffold(
          backgroundColor: Theme.of(context).colorScheme.surface,
          appBar: AppBar(
            title: const Text(
              'Business Dashboard',
            ),
            actions: [
              Obx(
                () => PopupMenuButton<AppThemeMode>(
                  icon: Icon(_getThemeIcon(themeController.currentThemeMode)),
                  tooltip: 'Theme Settings',
                  onSelected: themeController.setThemeMode,
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      value: AppThemeMode.light,
                      child: Row(
                        children: [
                          const Icon(Icons.light_mode),
                          const SizedBox(width: 8),
                          const Text('Light'),
                          if (themeController.currentThemeMode ==
                              AppThemeMode.light)
                            const Spacer(),
                          if (themeController.currentThemeMode ==
                              AppThemeMode.light)
                            const Icon(Icons.check),
                        ],
                      ),
                    ),
                    PopupMenuItem(
                      value: AppThemeMode.dark,
                      child: Row(
                        children: [
                          const Icon(Icons.dark_mode),
                          const SizedBox(width: 8),
                          const Text('Dark'),
                          if (themeController.currentThemeMode ==
                              AppThemeMode.dark)
                            const Spacer(),
                          if (themeController.currentThemeMode ==
                              AppThemeMode.dark)
                            const Icon(Icons.check),
                        ],
                      ),
                    ),
                    PopupMenuItem(
                      value: AppThemeMode.system,
                      child: Row(
                        children: [
                          const Icon(Icons.settings_suggest),
                          const SizedBox(width: 8),
                          const Text('System'),
                          if (themeController.currentThemeMode ==
                              AppThemeMode.system)
                            const Spacer(),
                          if (themeController.currentThemeMode ==
                              AppThemeMode.system)
                            const Icon(Icons.check),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () =>
                    Get.find<LanguageController>().showLanguageDialog(),
                icon: const Icon(Icons.language),
                tooltip: 'change_language'.tr,
              ),
              IconButton(
                onPressed: () => _showLogoutDialog(context),
                icon: const Icon(Icons.logout),
                tooltip: 'logout'.tr,
              ),
            ],
          ),
          drawer: const RoleBasedDrawer(),
          body: Obx(() {
            if (authController.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (authController.errorMessage.isNotEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.error_outline,
                      size: 64,
                      color: Theme.of(context).colorScheme.error,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      authController.errorMessage,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.error,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        authController.clearError();
                        authController.loadAdminDashboard();
                      },
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              );
            }

            final adminDashboard = authController.adminDashboard;
            if (adminDashboard == null) {
              return const Center(child: Text('No data available'));
            }

            return RefreshIndicator(
              onRefresh: () => authController.loadAdminDashboard(),
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildBusinessInfo(context, adminDashboard.data.business),
                    const SizedBox(height: 16),
                    _buildStatsGrid(context, adminDashboard.data.stats),
                    const SizedBox(height: 24),
                    _buildHospitalsList(context, adminDashboard.data.hospitals),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }

  Future<bool> _onWillPop() async {
    final now = DateTime.now();
    if (_lastBackPressed == null ||
        now.difference(_lastBackPressed!) > const Duration(seconds: 2)) {
      _lastBackPressed = now;
      Get.snackbar(
        'Press again to exit',
        'Tap back again to close the app',
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 2),
      );
      return false;
    }
    return true;
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Logout'),
          content: const Text('Are you sure you want to logout?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                authController.logout();
              },
              child: const Text('Logout'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildBusinessInfo(BuildContext context, dynamic business) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.business,
                    color: Theme.of(context).colorScheme.primary),
                const SizedBox(width: 8),
                Text(
                  business.name ?? 'Unknown Business',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text('Owner: ${business.ownerName ?? 'Unknown'}'),
            Text(
                'Type: ${(business.businessType ?? 'unknown').replaceAll('_', ' ').toUpperCase()}'),
          ],
        ),
      ),
    );
  }

  Widget _buildStatsGrid(BuildContext context, dynamic stats) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Overview Statistics',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 12),
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          crossAxisSpacing: 8,
          mainAxisSpacing: 12,
          childAspectRatio: 1.2,
          children: [
            _buildStatCard(
                context,
                'Hospitals',
                stats.totalHospitals.toString(),
                Icons.local_hospital,
                const Color(0xFF07BDFF)),
            _buildStatCard(
                context,
                'Total Patients',
                stats.totalPatients.toString(),
                Icons.people,
                const Color(0xFF145BD9)),
            _buildStatCard(
                context,
                'Staff Members',
                stats.totalStaff.toString(),
                Icons.group,
                const Color(0xFF145BD9)),
            _buildStatCard(
                context,
                "Today's Appointments",
                stats.appointmentsToday.toString(),
                Icons.calendar_today,
                const Color(0xFF07BDFF)),
          ],
        ),
      ],
    );
  }

  Widget _buildStatCard(BuildContext context, String title, String value,
      IconData icon, Color color) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 32, color: color),
            const SizedBox(height: 8),
            Text(
              value,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
            ),
            const SizedBox(height: 4),
            Text(title,
                style: Theme.of(context).textTheme.bodySmall,
                textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }

  Widget _buildHospitalsList(BuildContext context, List<dynamic> hospitals) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Hospital Branches',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 12),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: hospitals.length,
          itemBuilder: (context, index) {
            final hospital = hospitals[index];
            return Card(
              margin: const EdgeInsets.only(bottom: 8),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: hospital.isMain
                      ? const Color(0xFF07BDFF)
                      : const Color(0xFF145BD9),
                  child: Icon(
                    hospital.isMain ? Icons.star : Icons.local_hospital,
                    color: Colors.white,
                  ),
                ),
                title: Text(hospital.name,
                    style: const TextStyle(fontWeight: FontWeight.w600)),
                subtitle:
                    Text('Code: ${hospital.code} • Phone: ${hospital.phone}'),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {
                  Get.to(() => HospitalDashboardScreen(
                        hospitalId: hospital.id,
                        hospitalName: hospital.name,
                      ));
                },
              ),
            );
          },
        ),
      ],
    );
  }
}
