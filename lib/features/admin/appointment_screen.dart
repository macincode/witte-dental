import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:witte_dental_pms/core/constants/app_constants.dart';
import 'package:witte_dental_pms/core/controllers/theme_controller.dart';
import 'package:witte_dental_pms/features/admin/details_card.dart';

import '../shared/widgets/network_aware_widget.dart';

class AppointmentScreen extends StatefulWidget {
  const AppointmentScreen({super.key});

  @override
  State<AppointmentScreen> createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen> {
  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();

    return NetworkAwareWidget(
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: AppBar(
          title: const Text('Appointment'),
        ),
        body: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DashboardCard.buildHeaderCard(
                context,
                'Appointments Management',
                'View and manage all appointments',
                // actionButton: ElevatedButton.icon(
                //   onPressed: () {
                //     // Add your button action here
                //   },
                //   icon: const Icon(Icons.add, size: 18),
                //   label: const Text('New'),
                //   style: ElevatedButton.styleFrom(
                //     padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                //   ),
                // ),
              ),
              const SizedBox(height: 24),
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  children: [
                    DashboardCard(
                      title: 'Total Appointments',
                      icon: Icons.group,
                      count: '434',
                      onTap: () {
                        Get.toNamed(AppConstants.appointmentlistManagement);
                      },
                    ),
                    const DashboardCard(
                      title: 'Completed',
                      icon: Icons.pending_actions,
                      count: '24',
                    ),
                    const DashboardCard(
                      title: 'Rescheduled',
                      icon: Icons.pending_actions,
                      count: '24',
                    ),
                    const DashboardCard(
                      title: 'Today`s Appointments',
                      icon: Icons.check_circle,
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
