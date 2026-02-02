import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/admin_dashboard_controller.dart';

class HospitalDashboardTab extends StatelessWidget {
  const HospitalDashboardTab({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AdminDashboardController>();

    return Obx(() {
      final dashboardData = controller.dashboardData;
      final hospitalData = controller.hospitalData;

      if (dashboardData == null) return const SizedBox.shrink();

      return SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hospital Selector
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Select Hospital',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 12),
                    DropdownButtonFormField<int>(
                      initialValue: controller.selectedHospitalId,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        prefixIcon: const Icon(Icons.local_hospital),
                      ),
                      items: dashboardData.hospitals.map((hospital) {
                        return DropdownMenuItem<int>(
                          value: hospital.id,
                          child: Row(
                            children: [
                              if (hospital.isMain)
                                const Icon(
                                  Icons.star,
                                  size: 16,
                                  color: Color(0xFF07BDFF),
                                ),
                              if (hospital.isMain) const SizedBox(width: 4),
                              Expanded(
                                child: Text(
                                  hospital.name,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                      onChanged: (value) {
                        if (value != null) {
                          controller.loadHospitalData(value);
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            if (hospitalData != null) ...[
              // Hospital Stats
              Text(
                'Hospital Statistics',
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
                childAspectRatio: 1.3,
                children: [
                  _buildStatCard(
                    context,
                    'Patients',
                    hospitalData.stats.totalPatients.toString(),
                    Icons.people,
                    const Color(0xFF07BDFF),
                    hospitalData.stats.trends.patients,
                  ),
                  _buildStatCard(
                    context,
                    "Today's Appointments",
                    hospitalData.stats.todayAppointments.toString(),
                    Icons.calendar_today,
                    const Color(0xFF145BD9),
                    hospitalData.stats.trends.appointments,
                  ),
                  _buildStatCard(
                    context,
                    'Monthly Revenue',
                    '₹${hospitalData.stats.monthlyRevenue.toStringAsFixed(0)}',
                    Icons.attach_money,
                    const Color(0xFF4682B4),
                    hospitalData.stats.trends.revenue,
                  ),
                  _buildStatCard(
                    context,
                    'Active Staff',
                    hospitalData.stats.activeStaff.toString(),
                    Icons.group,
                    const Color(0xFF9370DB),
                    null,
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Additional Stats Row
              Row(
                children: [
                  Expanded(
                    child: _buildInfoCard(
                      context,
                      'Pending Appointments',
                      hospitalData.stats.pendingAppointments.toString(),
                      Icons.pending_actions,
                      Colors.orange,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildInfoCard(
                      context,
                      'Completed Treatments',
                      hospitalData.stats.completedTreatments.toString(),
                      Icons.check_circle,
                      Colors.green,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Recent Activities
              if (hospitalData.recentActivities.isNotEmpty) ...[
                Text(
                  'Recent Activities',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 12),
                Card(
                  child: ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: hospitalData.recentActivities.length,
                    separatorBuilder: (context, index) => const Divider(),
                    itemBuilder: (context, index) {
                      final activity = hospitalData.recentActivities[index];
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundColor:
                              const Color(0xFF07BDFF).withOpacity(0.1),
                          child: Icon(
                            _getActivityIcon(activity.icon),
                            color: const Color(0xFF07BDFF),
                          ),
                        ),
                        title: Text(activity.message),
                        subtitle: Text(activity.time),
                        trailing: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFF07BDFF).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            activity.type.replaceAll('_', ' ').toUpperCase(),
                            style: const TextStyle(
                              color: Color(0xFF07BDFF),
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ],
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
    dynamic trend,
  ) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(icon, size: 24, color: color),
                if (trend != null)
                  Icon(
                    trend.direction == 'up'
                        ? Icons.trending_up
                        : Icons.trending_down,
                    size: 16,
                    color: trend.direction == 'up' ? Colors.green : Colors.red,
                  ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
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
            if (trend != null) ...[
              const SizedBox(height: 4),
              Text(
                '${trend.value}%',
                style: TextStyle(
                  fontSize: 12,
                  color: trend.direction == 'up' ? Colors.green : Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(
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
          children: [
            Icon(icon, size: 32, color: color),
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

  IconData _getActivityIcon(String iconName) {
    switch (iconName) {
      case 'user-plus':
        return Icons.person_add;
      case 'calendar':
        return Icons.calendar_today;
      case 'medical':
        return Icons.medical_services;
      default:
        return Icons.info;
    }
  }
}
