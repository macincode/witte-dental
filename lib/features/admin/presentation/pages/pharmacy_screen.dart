import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:witte_dental_pms/core/constants/app_constants.dart';
import 'package:witte_dental_pms/core/controllers/theme_controller.dart';
import 'package:witte_dental_pms/features/admin/presentation/pages/details_card.dart';
import 'package:witte_dental_pms/features/admin/presentation/pages/pharmacyList_management.dart';

import '../../../shared/widgets/network_aware_widget.dart';

class PharmacyScreen extends StatefulWidget {
  const PharmacyScreen({super.key});

  @override
  State<PharmacyScreen> createState() => _PharmacyScreenState();
}

class _PharmacyScreenState extends State<PharmacyScreen> {
  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();

    return NetworkAwareWidget(
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: AppBar(
          title: const Text('Pharmacy'),
        ),
        body: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DashboardCard.buildHeaderCard(
                context,
                'Pharmacy Management',
                'Manage and track all medicines and pharmacy inventory',
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
                      AddPharmacyHelper.addPharmacySheet(context);
                    },
                    icon: const Icon(Icons.person_add, size: 18),
                    label: const Text('Add Medicine'),
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
                      title: 'Total Medicines',
                      icon: Icons.group,
                      count: '434',
                      onTap: () {
                        Get.toNamed(AppConstants.pharmacyListManagement);
                      },
                    ),
                    const DashboardCard(
                      title: 'Low Stock',
                      icon: Icons.person_pin,
                      count: '24',
                    ),
                    const DashboardCard(
                      title: 'Out of Stock',
                      icon: Icons.list,
                      count: '132',
                    ),
                    const DashboardCard(
                      title: 'Categories',
                      icon: Icons.category,
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
