import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:witte_dental_pms/core/constants/app_constants.dart';
import 'package:witte_dental_pms/core/controllers/theme_controller.dart';
import 'package:witte_dental_pms/features/admin/details_card.dart';
import 'package:witte_dental_pms/features/admin/patientList_management.dart';

import '../shared/widgets/network_aware_widget.dart';

class PatientScreen extends StatefulWidget {
  const PatientScreen({super.key});

  @override
  State<PatientScreen> createState() => _PatientScreenState();
}

class _PatientScreenState extends State<PatientScreen> {
  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();

    return NetworkAwareWidget(
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: AppBar(
          title: const Text('Patients'),
        ),
        body: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DashboardCard.buildHeaderCard(
                context,
                'Patient Management',
                'Manage and track all patient records',
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
                      AddPatientHelper.addPatientSheet(context);
                    },
                    icon: const Icon(Icons.person_add, size: 18),
                    label: const Text('Add Patient'),
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
                      title: 'Total Patients',
                      icon: Icons.group,
                      count: '434',
                      onTap: () {
                        Get.toNamed(AppConstants.patientlistManagement);
                      },
                    ),
                    const DashboardCard(
                      title: 'Male Patients',
                      icon: Icons.person,
                      count: '24',
                    ),
                    const DashboardCard(
                      title: 'Female Patients',
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
