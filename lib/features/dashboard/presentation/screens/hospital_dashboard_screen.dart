import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/models/hospital_dashboard_response.dart';
import '../controllers/hospital_dashboard_controller.dart';

class HospitalDashboardScreen extends StatelessWidget {
  final int hospitalId;
  final String hospitalName;

  const HospitalDashboardScreen({
    super.key,
    required this.hospitalId,
    required this.hospitalName,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HospitalDashboardController(hospitalId));

    return Scaffold(
      appBar: AppBar(
        title: Text(hospitalName),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      body: Obx(() {
        if (controller.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.errorMessage.isNotEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.error, size: 64, color: Colors.red),
                const SizedBox(height: 16),
                Text(controller.errorMessage),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: controller.loadDashboard,
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        }

        final data = controller.dashboardData;
        if (data == null) {
          return const Center(child: Text('No data available'));
        }

        return RefreshIndicator(
          onRefresh: controller.loadDashboard,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildStatsGrid(context, data.stats),
                const SizedBox(height: 24),
                _buildRecentActivities(context, data.recentActivities),
                const SizedBox(height: 24),
                _buildDelayStats(context, data.delayStats),
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget _buildStatsGrid(BuildContext context, HospitalStats stats) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Overview',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 16),
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 1.2,
          children: [
            _buildStatCard(
              context,
              'Total Patients',
              stats.totalPatients.toString(),
              Icons.people,
              const Color(0xFF07BDFF),
            ),
            _buildStatCard(
              context,
              'Today Appointments',
              stats.todayAppointments.toString(),
              Icons.calendar_today,
              const Color(0xFF145BD9),
            ),
            _buildStatCard(
              context,
              'Monthly Revenue',
              '₹${stats.monthlyRevenue.toStringAsFixed(0)}',
              Icons.attach_money,
              const Color(0xFF07BDFF),
            ),
            _buildStatCard(
              context,
              'Active Staff',
              stats.activeStaff.toString(),
              Icons.group,
              const Color(0xFF145BD9),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStatCard(
    BuildContext context,
    String title,
    String value,
    IconData icon,
    Color color,
  ) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: color, size: 24),
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
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.grey[600],
                  ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentActivities(
      BuildContext context, List<RecentActivity> activities) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Recent Activities',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 16),
        Card(
          child: ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: activities.length,
            separatorBuilder: (context, index) => const Divider(),
            itemBuilder: (context, index) {
              final activity = activities[index];
              return ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.blue.withOpacity(0.1),
                  child: Icon(Icons.info, color: Colors.blue),
                ),
                title: Text(activity.message),
                subtitle: Text(activity.time),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildDelayStats(BuildContext context, DelayStats delayStats) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Appointment Delays',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 16),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        '${delayStats.onTimePercentage}%',
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium
                            ?.copyWith(
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      const Text('On Time'),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        '${delayStats.avgDelayMinutes}min',
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium
                            ?.copyWith(
                              color: Colors.orange,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      const Text('Avg Delay'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
