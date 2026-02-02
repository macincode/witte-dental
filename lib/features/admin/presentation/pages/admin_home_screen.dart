import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:witte_dental_pms/core/controllers/language_controller.dart';
import 'package:witte_dental_pms/core/controllers/theme_controller.dart';
import 'package:witte_dental_pms/features/admin/presentation/controllers/admin_dashboard_controller.dart';
import 'package:witte_dental_pms/features/admin/presentation/widgets/admin_dashboard_tab.dart';
import 'package:witte_dental_pms/features/admin/presentation/widgets/hospital_dashboard_tab.dart';
import 'package:witte_dental_pms/features/shared/widgets/network_aware_widget.dart';
import 'package:witte_dental_pms/features/shared/widgets/role_based_drawer.dart';

class AdminHomeScreen extends StatefulWidget {
  const AdminHomeScreen({super.key});

  @override
  State<AdminHomeScreen> createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen>
    with SingleTickerProviderStateMixin {
  final themeController = Get.find<ThemeController>();
  late TabController _tabController;
  late AdminDashboardController _controller;

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
    _tabController = TabController(length: 2, vsync: this);
    _controller = Get.put(AdminDashboardController(Get.find()));
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return NetworkAwareWidget(
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: AppBar(
          title: Text(
            'Admin Dashboard',
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurface,
              fontWeight: FontWeight.w600,
            ),
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
              onPressed: () {},
              icon: const Icon(Icons.logout),
              tooltip: 'logout'.tr,
            ),
          ],
          bottom: TabBar(
            controller: _tabController,
            tabs: const [
              Tab(
                icon: Icon(Icons.dashboard),
                text: 'Overview',
              ),
              Tab(
                icon: Icon(Icons.local_hospital),
                text: 'Hospitals',
              ),
            ],
            labelColor: Theme.of(context).colorScheme.primary,
            unselectedLabelColor:
                Theme.of(context).colorScheme.onSurfaceVariant,
            indicatorColor: Theme.of(context).colorScheme.primary,
          ),
        ),
        drawer: const RoleBasedDrawer(),
        body: Obx(() {
          if (_controller.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (_controller.errorMessage.isNotEmpty) {
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
                    _controller.errorMessage,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.error,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      _controller.clearError();
                      _controller.loadDashboard();
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          return TabBarView(
            controller: _tabController,
            children: const [
              AdminDashboardTab(),
              HospitalDashboardTab(),
            ],
          );
        }),
      ),
    );
  }
}
