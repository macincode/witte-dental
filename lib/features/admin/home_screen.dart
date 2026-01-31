import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:witte_dental_pms/core/constants/app_constants.dart';
import 'package:witte_dental_pms/core/controllers/theme_controller.dart';
import 'package:witte_dental_pms/features/admin/appointment_screen.dart';

import '../../core/controllers/language_controller.dart';
import '../auth/presentation/controllers/auth_controller.dart';
import '../shared/widgets/network_aware_widget.dart';
import '../shared/widgets/role_based_drawer.dart';
import '../shared/widgets/theme_aware_app_bar.dart';
import 'details_card.dart';

class AdminHomeScreen extends StatefulWidget {
  const AdminHomeScreen({super.key});

  @override
  State<AdminHomeScreen> createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  final themeController = Get.find<ThemeController>();

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
  Widget build(BuildContext context) {
    return NetworkAwareWidget(
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        //  drawer: const RoleBasedDrawer(),
        appBar: AppBar(
          title: Row(
            children: [
              Container(
                  padding: const EdgeInsets.all(5),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  child: Icon(Icons.admin_panel_settings_sharp,
                      color: Theme.of(context).colorScheme.primary)),
              const SizedBox(width: 8),
              Text('Admin'.tr),
            ],
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
              Container(
                padding: const EdgeInsets.all(20),
                decoration:
                    themeController.currentThemeMode == AppThemeMode.dark ||
                            (themeController.currentThemeMode ==
                                    AppThemeMode.system &&
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
                                offset: const Offset(1, 1),
                              ),
                            ],
                          )
                        : BoxDecoration(
                            color: Theme.of(context).colorScheme.surface,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSecondary
                                  .withOpacity(0.12),
                              width: 2,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 0.8,
                                blurRadius: 10,
                                offset: const Offset(0, 1),
                              ),
                            ],
                          ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Welcome to Witte Dental Care Management System',
                      style: Theme.of(context).textTheme.displayLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context)
                                .colorScheme
                                .onSecondary
                                .withOpacity(0.85),
                          ),
                    ),
                    const SizedBox(height: 15),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.only(left: 8),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Theme.of(context).colorScheme.secondary,
                                  Theme.of(context).colorScheme.primary,
                                ],
                                begin: Alignment.bottomLeft,
                                end: Alignment.topRight,
                              ),
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.blue.withOpacity(0.3),
                                  blurRadius: 6,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: ElevatedButton.icon(
                              onPressed: () {
                                AppointmentDialogHelper.showBookingOptions(
                                    context);
                              },
                              icon: const Icon(Icons.calendar_today_outlined,
                                  size: 16, color: Colors.white),
                              label: const Text('Book Appointment',
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14)),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                shadowColor: Colors.transparent,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 12),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Theme.of(context).colorScheme.secondary,
                                  Theme.of(context).colorScheme.primary,
                                ],
                                begin: Alignment.bottomLeft,
                                end: Alignment.topRight,
                              ),
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.blue.withOpacity(0.3),
                                  blurRadius: 6,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: ElevatedButton.icon(
                              onPressed: () {
                                Get.toNamed(AppConstants.patientlistManagement);
                              },
                              icon: const Icon(Icons.group,
                                  size: 16, color: Colors.white),
                              label: const Text('View Patients',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14)),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                shadowColor: Colors.transparent,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 12),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  children: [
                    DashboardCard(
                      title: 'Dashboard',
                      icon: Icons.home,
                      //  count: '434',
                      onTap: () {
                        Get.toNamed(AppConstants.doctorDashboard);
                      },
                    ),
                    DashboardCard(
                      title: 'Inquiries',
                      icon: Icons.chat,
                      //  count: '434',
                      onTap: () {
                        Get.toNamed(AppConstants.inquiryScreen);
                      },
                    ),
                    DashboardCard(
                      title: 'Appointments',
                      icon: Icons.calendar_month,
                      // count: '24',
                      onTap: () {
                        Get.toNamed(AppConstants.appointmentScreen);
                      },
                    ),
                    DashboardCard(
                      title: 'Patients',
                      icon: Icons.person,
                      // count: '434',
                      onTap: () {
                        Get.toNamed(AppConstants.patientScreen);
                      },
                    ),
                     DashboardCard(
                      title: 'Doctor',
                      icon: Icons.medical_services,
                      // count: '434',
                       onTap: () {
                        Get.toNamed(AppConstants.doctorScreen);
                      },
                    ),
                     DashboardCard(
                      title: 'Staff',
                      icon: Icons.safety_check,
                      // count: '434',
                      onTap: () {
                        Get.toNamed(AppConstants.staffScreen);
                      },
                    ),
                     DashboardCard(
                      title: 'Inventory',
                      icon: Icons.inventory,
                      // count: '434',
                      onTap: () {
                        Get.toNamed(AppConstants.inventoryScreen);
                      },
                    ),
                     DashboardCard(
                      title: 'Pharmacy',
                      icon: Icons.local_pharmacy,
                      // count: '434',
                      onTap: () {
                        Get.toNamed(AppConstants.pharmacyScreen);
                      },
                    ),
                    const DashboardCard(
                      title: 'Accounts',
                      icon: Icons.account_balance,
                      // count: '434',
                    ),
                    const DashboardCard(
                      title: 'Settings',
                      icon: Icons.settings,
                      // count: '132',
                    ),
                    const DashboardCard(
                      title: 'Events',
                      icon: Icons.event,
                      // count: '98%',
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
