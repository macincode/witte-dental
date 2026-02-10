import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:witte_dental_pms/core/constants/app_constants.dart';
import 'package:witte_dental_pms/core/controllers/theme_controller.dart';
import 'package:witte_dental_pms/features/admin/presentation/controllers/admin_patient_controller.dart';
import 'package:witte_dental_pms/features/admin/presentation/pages/details_card.dart';
import 'package:witte_dental_pms/features/admin/presentation/pages/patientList_management.dart';
import 'package:witte_dental_pms/features/shared/widgets/global_widgets.dart';

import '../../../shared/widgets/network_aware_widget.dart';

class PatientScreen extends StatefulWidget {
  const PatientScreen({super.key});

  @override
  State<PatientScreen> createState() => _PatientScreenState();
}

class _PatientScreenState extends State<PatientScreen> {
   final AdminPatientController _patientController =
      Get.put(AdminPatientController());

  @override
  void initState() {
    super.initState();
     _patientController.getPatientListData();
  }

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();

    return NetworkAwareWidget(
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
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
                      dPrint('patient list----');
                      dPrint('${_patientController.adminPatientList.length}');
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
                    Obx(
                      () => DashboardCard(
                        title: 'Total Patients',
                        icon: Icons.group,
                        count: '${_patientController.adminPatientList.length}',
                        onTap: () {
                          Get.toNamed(AppConstants.patientListManagement);
                        },
                      ),
                    ),
                    Obx(
                      () => DashboardCard(
                        title: 'Male Patients',
                        icon: Icons.person,
                        count: '${_patientController.adminPatientList.where((patient) => patient['gender']?.toString().toLowerCase() == 'male').length}',
                      ),
                    ),
                    Obx(
                      () => DashboardCard(
                        title: 'Female Patients',
                        icon: Icons.person,
                        count: '${_patientController.adminPatientList.where((patient) => patient['gender']?.toString().toLowerCase() == 'female').length}',
                      ),
                    ),
                    Obx(
                      () => DashboardCard(
                        title: 'New (30 days)',
                        icon: Icons.person_add,
                        count: '${_patientController.adminPatientList.where((patient) {
                          if (patient['created_at'] == null) return false;
                          try {
                            final createdAt = DateTime.parse(patient['created_at']);
                            final thirtyDaysAgo = DateTime.now().subtract(const Duration(days: 30));
                            return createdAt.isAfter(thirtyDaysAgo);
                          } catch (e) {
                            return false;
                          }
                        }).length}',
                      ),
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
