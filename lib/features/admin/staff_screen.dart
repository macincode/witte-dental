import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:witte_dental_pms/core/constants/app_constants.dart';
import 'package:witte_dental_pms/core/controllers/theme_controller.dart';
import 'package:witte_dental_pms/features/admin/details_card.dart';
import 'package:witte_dental_pms/features/admin/staffList_management.dart';

import '../shared/widgets/network_aware_widget.dart';

class StaffScreen extends StatefulWidget {
  const StaffScreen({super.key});

  @override
  State<StaffScreen> createState() => _StaffScreenState();
}

class _StaffScreenState extends State<StaffScreen> {
  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();

    return NetworkAwareWidget(
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: AppBar(
          title: const Text('Staff'),
        ),
        body: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DashboardCard.buildHeaderCard(
                context,
                'Staff Management',
                'Manage and track all staff members',
                actionButton: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Theme.of(context).colorScheme.secondary,
                        Theme.of(context).colorScheme.primary,
                      ],
                      begin: Alignment.bottomLeft,
                      end: Alignment.topRight,
                    ),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: ElevatedButton.icon(
                    onPressed: () {
                      AddStaffHelper.addStaffSheet(context);
                    },
                    icon: const Icon(Icons.person_add, size: 18),
                    label: const Text('Add Staff'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  children: [
                    DashboardCard(
                      title: 'Total Staff',
                      icon: Icons.group,
                      count: '434',
                      onTap: () {
                        Get.toNamed(AppConstants.stafflistManagement);
                      },
                    ),
                    const DashboardCard(
                      title: 'Active Staff',
                      icon: Icons.person_pin,
                      count: '24',
                    ),
                    const DashboardCard(
                      title: 'Inactive Staff',
                      icon: Icons.person,
                      count: '132',
                    ),
                    const DashboardCard(
                      title: 'New (30 days)',
                      icon: Icons.person_add,
                      count: '132',
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
