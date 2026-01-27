import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wittehms/core/controllers/theme_controller.dart';

import '../../core/controllers/language_controller.dart';
import '../auth/presentation/controllers/auth_controller.dart';
import 'details_card.dart';
import '../shared/widgets/network_aware_widget.dart';
import '../shared/widgets/role_based_drawer.dart';
import '../shared/widgets/theme_aware_app_bar.dart';

class AdminDashboard extends StatelessWidget {
   AdminDashboard({super.key});

  final themeController = Get.find<ThemeController>();

  @override
  Widget build(BuildContext context) {

    

    return NetworkAwareWidget(
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
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
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
            
              const SizedBox(height: 16),
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  children: const [
                    DashboardCard(
                      title: 'Total Patients',
                      icon: Icons.group,
                      count: '434',
                    ),
                    DashboardCard(
                      title: 'Appointments',
                      icon: Icons.calendar_month,
                      count: '24',
                    ),
                    DashboardCard(
                      title: 'Montly Revenue',
                      icon: Icons.payment_rounded,
                      count: '132',
                    ),
                    DashboardCard(
                      title: 'Active Staff',
                      icon: Icons.monitor_heart,
                      count: '98%',
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


}
