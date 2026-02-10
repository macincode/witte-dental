import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:witte_dental_pms/core/constants/app_constants.dart';
import 'package:witte_dental_pms/core/controllers/theme_controller.dart';
import 'package:witte_dental_pms/features/admin/presentation/controllers/admin_doctor_controller.dart';
import 'package:witte_dental_pms/features/admin/presentation/pages/details_card.dart';
import 'package:witte_dental_pms/features/admin/presentation/pages/doctorList_management.dart';
import 'package:witte_dental_pms/features/admin/presentation/repositories/admin_doctor_repo.dart';
import 'package:witte_dental_pms/features/shared/widgets/global_widgets.dart';

import '../../../shared/widgets/network_aware_widget.dart';

class DoctorScreen extends StatefulWidget {
  const DoctorScreen({super.key});

  @override
  State<DoctorScreen> createState() => _DoctorScreenState();
}

class _DoctorScreenState extends State<DoctorScreen> {
  final AdminDoctorController _doctorController =
      Get.put(AdminDoctorController());

  @override
  void initState() {
    super.initState();
    _doctorController.getDoctorListData();
  }

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();

    return NetworkAwareWidget(
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: AppBar(
          title: const Text('Doctors'),
        ),
        body: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DashboardCard.buildHeaderCard(
                context,
                'Doctor Management',
                'Manage and track all doctors and medical staff ',
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
                      dPrint('doctor list----');
                      dPrint('${_doctorController.adminDoctorList.length}');
                      AddDoctorHelper.addDoctorSheet(context);
                    },
                    icon: const Icon(Icons.person_add, size: 18),
                    label: const Text('Add Doctor'),
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
                        title: 'Total Doctors',
                        icon: Icons.group,
                        count: '${_doctorController.adminDoctorList.length}',
                        onTap: () {
                          Get.toNamed(AppConstants.doctorListManagement);
                        },
                      ),
                    ),
                    Obx(
                      () => DashboardCard(
                        title: 'Active Doctors',
                        icon: Icons.person_pin,
                        count: '${_doctorController.adminDoctorList.where((doctor) => doctor['status'] == 1).length}',
                      ),
                    ),
                    Obx(
                      () => DashboardCard(
                        title: 'Inactive Doctors',
                        icon: Icons.person,
                        count: '${_doctorController.adminDoctorList.where((doctor) => doctor['status'] == 0 || doctor['status'] == null).length}',
                      ),
                    ),
                    const DashboardCard(
                      title: 'Departments',
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
