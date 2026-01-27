import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/controllers/language_controller.dart';
import '../auth/presentation/controllers/auth_controller.dart';
import '../shared/widgets/network_aware_widget.dart';
import '../shared/widgets/role_based_drawer.dart';
import '../shared/widgets/theme_aware_app_bar.dart';

class AdminDashboard extends StatelessWidget {
  const AdminDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return NetworkAwareWidget(
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        drawer: const RoleBasedDrawer(),
        appBar: ThemeAwareAppBar(
          title: 'Dashboard'.tr,
          actions: [
            IconButton(
              onPressed: () =>
                  Get.find<LanguageController>().showLanguageDialog(),
              icon: const Icon(Icons.language),
              tooltip: 'change_language'.tr,
            ),
            IconButton(
              onPressed: () => Get.find<AuthController>().logout(),
              icon: const Icon(Icons.logout),
              tooltip: 'logout'.tr,
            ),
          ],
        ),
        body: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.admin_panel_settings,
                            color: Theme.of(context).colorScheme.primary,
                            size: 32,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              'welcome_admin'.tr,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.headlineSmall,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'manage_system_desc'.tr,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  children: [
                    _buildDashboardCard(
                      context,
                      'Total Patients',
                      Icons.group,
                      '434',
                      Colors.blue,
                    ),
                    _buildDashboardCard(
                      context,
                      'Appointments',
                      Icons.medical_services,
                      '24',
                      Colors.green,
                    ),
                    _buildDashboardCard(
                      context,
                      'Montly Revenue',
                      Icons.people,
                      '132',
                      Colors.orange,
                    ),
                    _buildDashboardCard(
                      context,
                      'Active Staff',
                      Icons.monitor_heart,
                      '98%',
                      Colors.purple,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDashboardCard(
    BuildContext context,
    String title,
    IconData icon,
    String count,
    Color color,
  ) {
    return InkWell(
      onTap: () {},
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: context.theme.cardColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Theme.of(context).colorScheme.onSecondary.withOpacity(0.1),
            width: 2,
          ),
          boxShadow: context.theme == ThemeData.dark()
              ? []
              : [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 0.8,
                    blurRadius: 10,
                    offset: const Offset(0, 1),
                  ),
                ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Icon(
                  icon,
                  size: 32,
                  color: color,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                count,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: Theme.of(context).colorScheme.onPrimary,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 4),
              Text(
                title,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onSecondary,
                      fontWeight: FontWeight.bold,
                    ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
