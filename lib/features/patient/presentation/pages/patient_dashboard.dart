import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../auth/presentation/controllers/auth_controller.dart';
import '../../../shared/widgets/theme_aware_app_bar.dart';
import '../../../shared/widgets/network_aware_widget.dart';

class PatientDashboard extends StatelessWidget {
  const PatientDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return NetworkAwareWidget(
      child: Scaffold(
      appBar: ThemeAwareAppBar(
        title: 'Patient Dashboard',
        actions: [
          IconButton(
            onPressed: () => Get.find<AuthController>().logout(),
            icon: const Icon(Icons.logout),
            tooltip: 'Logout',
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
                          Icons.person,
                          color: Theme.of(context).colorScheme.primary,
                          size: 32,
                        ),
                        const SizedBox(width: 12),
                        Text(
                          'Welcome Patient!',
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Access your medical records, book appointments, and manage your health.',
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
                    'Appointments',
                    Icons.event,
                    '3',
                    Colors.blue,
                  ),
                  _buildDashboardCard(
                    context,
                    'Prescriptions',
                    Icons.medication,
                    '2',
                    Colors.green,
                  ),
                  _buildDashboardCard(
                    context,
                    'Medical History',
                    Icons.history,
                    '15',
                    Colors.orange,
                  ),
                  _buildDashboardCard(
                    context,
                    'Health Reports',
                    Icons.assessment,
                    '7',
                    Colors.purple,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }

  Widget _buildDashboardCard(
    BuildContext context,
    String title,
    IconData icon,
    String count,
    Color color,
  ) {
    return Card(
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 32,
                color: color,
              ),
              const SizedBox(height: 8),
              Text(
                count,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: color,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                title,
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}