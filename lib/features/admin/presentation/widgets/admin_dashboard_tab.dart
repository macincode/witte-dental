import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/admin_dashboard_controller.dart';

class AdminDashboardTab extends StatelessWidget {
  const AdminDashboardTab({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AdminDashboardController>();

    return Obx(() {
      final data = controller.dashboardData;
      if (data == null) return const SizedBox.shrink();

      return SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Business Info Card
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.business,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          data.business.name,
                          style:
                              Theme.of(context).textTheme.titleLarge?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Owner: ${data.business.ownerName}',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    Text(
                      'Type: ${data.business.businessType.replaceAll('_', ' ').toUpperCase()}',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Stats Grid
            Text(
              'Overview Statistics',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 12),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 1.5,
              children: [
                _buildStatCard(
                  context,
                  'Hospitals',
                  data.stats.totalHospitals.toString(),
                  Icons.local_hospital,
                  const Color(0xFF07BDFF),
                ),
                _buildStatCard(
                  context,
                  'Total Patients',
                  data.stats.totalPatients.toString(),
                  Icons.people,
                  const Color(0xFF145BD9),
                ),
                _buildStatCard(
                  context,
                  'Staff Members',
                  data.stats.totalStaff.toString(),
                  Icons.group,
                  const Color(0xFF4682B4),
                ),
                _buildStatCard(
                  context,
                  "Today's Appointments",
                  data.stats.appointmentsToday.toString(),
                  Icons.calendar_today,
                  const Color(0xFF9370DB),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Hospitals List
            Text(
              'Hospital Branches',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 12),
            ...data.hospitals.map(
              (hospital) => Card(
                margin: const EdgeInsets.only(bottom: 8),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: hospital.isMain
                        ? const Color(0xFF07BDFF)
                        : const Color(0xFF145BD9),
                    child: Icon(
                      hospital.isMain ? Icons.star : Icons.local_hospital,
                      color: Colors.white,
                    ),
                  ),
                  title: Text(
                    hospital.name,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Code: ${hospital.code}'),
                      Text('Phone: ${hospital.phone}'),
                    ],
                  ),
                  trailing: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: hospital.status == 'active'
                          ? Colors.green.withOpacity(0.1)
                          : Colors.red.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      hospital.status.toUpperCase(),
                      style: TextStyle(
                        color: hospital.status == 'active'
                            ? Colors.green
                            : Colors.red,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  isThreeLine: true,
                ),
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget _buildStatCard(
    BuildContext context,
    String title,
    String value,
    IconData icon,
    Color color,
  ) {
    return Card(
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
              value,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
            ),
            const SizedBox(height: 4),
            Text(
              title,
              style: Theme.of(context).textTheme.bodySmall,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
