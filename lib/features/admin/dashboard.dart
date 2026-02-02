import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:witte_dental_pms/core/controllers/theme_controller.dart';

import '../shared/widgets/network_aware_widget.dart';

class AdminDashboard extends StatelessWidget {
  AdminDashboard({super.key});

  final themeController = Get.find<ThemeController>();

  @override
  Widget build(BuildContext context) {
    return NetworkAwareWidget(
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        // drawer: const RoleBasedDrawer(),
        appBar: AppBar(
          title: Text('Dashboard'.tr),
        ),
        body: SizedBox(
          width: double.infinity,
          // padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const SizedBox(height: 16),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  spacing: 10,
                  children: [
                    const SizedBox(width: 10),
                    _buildCard(context, 'Total Patients', Icons.person, '20'),
                    _buildCard(
                        context, 'Appointments', Icons.calendar_today, '15'),
                    _buildCard(
                        context, 'Treatments', Icons.medical_services, '8'),
                    _buildCard(
                        context, 'Revenue', Icons.attach_money, r'$2,500'),
                    _buildCard(context, 'Staff', Icons.group, '5'),
                    _buildCard(context, 'Equipment', Icons.build, '12'),
                    _buildCard(context, 'Reports', Icons.analytics, '3'),
                    const SizedBox(width: 10),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCard(
      BuildContext context, String title, IconData icon, String value) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: themeController.currentThemeMode == AppThemeMode.dark ||
              (themeController.currentThemeMode == AppThemeMode.system &&
                  Theme.of(context).brightness == Brightness.dark)
          ? BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: const Color(0xff30363d),
                width: 2,
              ),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xff30363d).withOpacity(0.2),
                  spreadRadius: 0.6,
                  blurRadius: 3,
                  offset: const Offset(-1, 1),
                ),
              ],
            )
          : BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color:
                    Theme.of(context).colorScheme.onSecondary.withOpacity(0.12),
                width: 2,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 0.8,
                  blurRadius: 10,
                  offset: const Offset(4, 8),
                ),
              ],
            ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Theme.of(context).colorScheme.primary.withOpacity(0.06),
                  Theme.of(context).colorScheme.secondary.withOpacity(0.3),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Icon(
              icon,
              size: 32,
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
          const SizedBox(width: 20),
          Column(
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onSecondary,
                      fontWeight: FontWeight.bold,
                    ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 2,
              ),
              Text(
                value,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: Theme.of(context).colorScheme.onPrimary,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
