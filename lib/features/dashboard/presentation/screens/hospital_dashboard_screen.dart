import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/models/hospital_dashboard_response.dart';
import '../controllers/hospital_dashboard_controller.dart';

class HospitalDashboardScreen extends StatefulWidget {
  const HospitalDashboardScreen({
    required this.hospitalId,
    required this.hospitalName,
    super.key,
  });
  final int hospitalId;
  final String hospitalName;

  @override
  State<HospitalDashboardScreen> createState() =>
      _HospitalDashboardScreenState();
}

class _HospitalDashboardScreenState extends State<HospitalDashboardScreen> {
  // Brand Colors
  final Color _primaryBlue = const Color(0xFF145BD9);
  final Color _lightBlue = const Color(0xFF07BDFF);
  final Color _purple = const Color(0xFF7B61FF);
  final Color _orange = const Color(0xFFFF9F43);

  late HospitalDashboardController _controller;

  @override
  void initState() {
    super.initState();
    _controller = Get.put(HospitalDashboardController(widget.hospitalId));
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor =
        isDark ? const Color(0xFF121212) : const Color(0xFFF8F9FD);
    final cardColor = isDark ? const Color(0xFF1E1E1E) : Colors.white;
    final textColor = isDark ? Colors.white : Colors.black87;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: Obx(() {
        if (_controller.isLoading) {
          return Center(child: CircularProgressIndicator(color: _primaryBlue));
        }

        if (_controller.errorMessage.isNotEmpty) {
          return _buildErrorState(context, _controller.errorMessage);
        }

        final data = _controller.dashboardData;
        if (data == null) return const Center(child: Text('No data available'));

        return RefreshIndicator(
          onRefresh: _controller.loadDashboard,
          color: _primaryBlue,
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              _buildSliverAppBar(context, isDark, widget.hospitalName),
              SliverPadding(
                padding: const EdgeInsets.all(20),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    _buildSectionHeader(
                      context,
                      'Performance Trends',
                      textColor,
                    ),
                    _buildTrendsGrid(
                      context,
                      data.stats,
                      cardColor,
                      textColor,
                      isDark,
                    ),
                    const SizedBox(height: 20),
                    _buildSectionHeader(
                      context,
                      'Financial Analytics',
                      textColor,
                    ),
                    const SizedBox(height: 12),
                    _buildRevenueChartCard(
                      context,
                      data.revenueChart,
                      cardColor,
                      textColor,
                      isDark,
                    ),
                    const SizedBox(height: 20),
                    _buildSectionHeader(
                      context,
                      'Operational Efficiency',
                      textColor,
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: _buildEfficiencyCard(
                            context,
                            'On-Time Rate',
                            '${data.delayStats.onTimePercentage}%',
                            Colors.green,
                            data.delayStats.onTimePercentage.toDouble() / 100,
                            cardColor,
                            textColor,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: _buildEfficiencyCard(
                            context,
                            'Collection Rate',
                            '${data.paymentStats.collectionRate}%',
                            _primaryBlue,
                            data.paymentStats.collectionRate.toDouble() / 100,
                            cardColor,
                            textColor,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    _buildSectionHeader(
                      context,
                      'Patient Demographics',
                      textColor,
                    ),
                    const SizedBox(height: 12),
                    _buildDemographicsCard(
                      context,
                      data.quickStats.patientDemographics,
                      cardColor,
                      textColor,
                    ),
                    const SizedBox(height: 20),
                    _buildSectionHeader(context, 'Recent Activity', textColor),
                    const SizedBox(height: 12),
                    _buildActivityList(
                      context,
                      data.recentActivities,
                      cardColor,
                      textColor,
                      isDark,
                    ),
                    const SizedBox(height: 40),
                  ]),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  // --- UI Components ---

  Widget _buildSliverAppBar(BuildContext context, bool isDark, String title) {
    return SliverAppBar(
      floating: true,
      pinned: true,
      elevation: 0,
      backgroundColor: isDark ? const Color(0xFF1E1E1E) : Colors.white,
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back_ios_new_rounded,
          color: isDark ? Colors.white : Colors.black87,
        ),
        onPressed: Get.back,
      ),
      title: Text(
        title,
        style: TextStyle(
          color: isDark ? Colors.white : Colors.black87,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.calendar_month_outlined, color: _primaryBlue),
          onPressed: () {}, // Future: Filter by date
        ),
      ],
    );
  }

  Widget _buildSectionHeader(
    BuildContext context,
    String title,
    Color textColor,
  ) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: textColor,
        letterSpacing: 0.5,
      ),
    );
  }

  Widget _buildTrendsGrid(
    BuildContext context,
    HospitalStats stats,
    Color cardColor,
    Color textColor,
    bool isDark,
  ) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          crossAxisSpacing: 6,
          mainAxisSpacing: 6,
          childAspectRatio: 1.3,
          children: [
            _buildTrendCard(
              'Total Patients',
              stats.totalPatients.toString(),
              stats.trends.patients.direction ?? 'flat',
              Icons.people_alt_rounded,
              _lightBlue,
              cardColor,
              textColor,
              isDark,
            ),
            _buildTrendCard(
              'Revenue',
              '₹${stats.monthlyRevenue}', // Format appropriately
              stats.trends.revenue.direction ?? 'flat',
              Icons.currency_rupee_rounded,
              const Color(0xFF00C853), // Green for money
              cardColor,
              textColor,
              isDark,
            ),
            _buildTrendCard(
              'Appointments',
              stats.todayAppointments.toString(),
              stats.trends.appointments.direction ?? 'flat',
              Icons.calendar_today_rounded,
              _purple,
              cardColor,
              textColor,
              isDark,
            ),
            _buildTrendCard(
              'Active Staff',
              stats.activeStaff.toString(),
              'flat', // Staff usually doesn't have a trend in API yet
              Icons.medical_services_rounded,
              _orange,
              cardColor,
              textColor,
              isDark,
            ),
          ],
        );
      },
    );
  }

  Widget _buildTrendCard(
    String title,
    String value,
    String trend,
    IconData icon,
    Color accentColor,
    Color cardColor,
    Color textColor,
    bool isDark,
  ) {
    final isUp = trend == 'up';
    final trendIcon = isUp
        ? Icons.trending_up
        : (trend == 'down' ? Icons.trending_down : Icons.remove);
    final trendColor =
        isUp ? Colors.green : (trend == 'down' ? Colors.red : Colors.grey);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          if (!isDark)
            BoxShadow(
              color: Colors.grey.withOpacity(0.08),
              blurRadius: 15,
              offset: const Offset(0, 5),
            ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: accentColor.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: accentColor, size: 18),
              ),
              if (trend != 'flat') Icon(trendIcon, color: trendColor, size: 20),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
              ),
              Text(
                title,
                style: TextStyle(
                  fontSize: 12,
                  color: isDark ? Colors.grey[400] : Colors.grey[600],
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRevenueChartCard(
    BuildContext context,
    RevenueChart chartData,
    Color cardColor,
    Color textColor,
    bool isDark,
  ) {
    // Transform data for chart
    final spots = chartData.monthlyData.asMap().entries.map((e) {
      return FlSpot(e.key.toDouble(), e.value.revenue);
    }).toList();

    return Container(
      height: 300,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          if (!isDark)
            BoxShadow(
              color: Colors.grey.withOpacity(0.08),
              blurRadius: 15,
              offset: const Offset(0, 5),
            ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Total Revenue',
                    style: TextStyle(
                      color: isDark ? Colors.grey[400] : Colors.grey[600],
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '₹${chartData.totalRevenue}',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                  ),
                ],
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: _primaryBlue.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  'Last 6 Months',
                  style: TextStyle(
                    color: _primaryBlue,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Expanded(
            child: LineChart(
              LineChartData(
                gridData: const FlGridData(show: false),
                titlesData: FlTitlesData(
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        if (value.toInt() >= 0 &&
                            value.toInt() < chartData.monthlyData.length) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Text(
                              chartData.monthlyData[value.toInt()].month,
                              style: TextStyle(
                                color: isDark
                                    ? Colors.grey[500]
                                    : Colors.grey[600],
                                fontSize: 10,
                              ),
                            ),
                          );
                        }
                        return const Text('');
                      },
                      interval: 1,
                    ),
                  ),
                  leftTitles: const AxisTitles(),
                  topTitles: const AxisTitles(),
                  rightTitles: const AxisTitles(),
                ),
                borderData: FlBorderData(show: false),
                minX: 0,
                maxX: (chartData.monthlyData.length - 1).toDouble(),
                minY: 0,
                lineBarsData: [
                  LineChartBarData(
                    spots: spots,
                    isCurved: true,
                    color: _primaryBlue,
                    barWidth: 3,
                    isStrokeCapRound: true,
                    dotData: const FlDotData(show: false),
                    belowBarData: BarAreaData(
                      show: true,
                      gradient: LinearGradient(
                        colors: [
                          _primaryBlue.withOpacity(0.2),
                          _primaryBlue.withOpacity(0),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEfficiencyCard(
    BuildContext context,
    String title,
    String value,
    Color color,
    double percent,
    Color cardColor,
    Color textColor,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          if (Theme.of(context).brightness == Brightness.light)
            BoxShadow(
              color: Colors.grey.withOpacity(0.08),
              blurRadius: 15,
              offset: const Offset(0, 5),
            ),
        ],
      ),
      child: Column(
        children: [
          SizedBox(
            height: 80,
            width: 80,
            child: Stack(
              children: [
                Center(
                  child: SizedBox(
                    width: 80,
                    height: 80,
                    child: CircularProgressIndicator(
                      value: percent,
                      backgroundColor: color.withOpacity(0.1),
                      color: color,
                      strokeWidth: 8,
                      strokeCap: StrokeCap.round,
                    ),
                  ),
                ),
                Center(
                  child: Text(
                    '${(percent * 100).toInt()}%',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Text(
            title,
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDemographicsCard(
    BuildContext context,
    PatientDemographics demographics,
    Color cardColor,
    Color textColor,
  ) {
    final male = demographics.genderDistribution.male;
    final female = demographics.genderDistribution.female;

    // Safety check for empty data
    if (male.count == 0 && female.count == 0) {
      return Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: const Center(child: Text('No demographic data yet')),
      );
    }

    return Container(
      height: 220,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        children: [
          Expanded(
            child: PieChart(
              PieChartData(
                sectionsSpace: 4,
                centerSpaceRadius: 30,
                sections: [
                  PieChartSectionData(
                    color: _primaryBlue,
                    value: male.percentage.toDouble(),
                    title: '',
                    radius: 20,
                  ),
                  PieChartSectionData(
                    color: const Color(0xFFFF6B6B), // Soft Red/Pink for female
                    value: female.percentage.toDouble(),
                    title: '',
                    radius: 20,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildLegendItem(
                  'Male',
                  '${male.percentage}%',
                  _primaryBlue,
                  textColor,
                ),
                const SizedBox(height: 10),
                _buildLegendItem(
                  'Female',
                  '${female.percentage}%',
                  const Color(0xFFFF6B6B),
                  textColor,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLegendItem(
    String label,
    String value,
    Color color,
    Color textColor,
  ) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 8),
        Text(label, style: TextStyle(color: Colors.grey[600], fontSize: 12)),
        const Spacer(),
        Text(
          value,
          style: TextStyle(fontWeight: FontWeight.bold, color: textColor),
        ),
      ],
    );
  }

  Widget _buildActivityList(
    BuildContext context,
    List<RecentActivity> activities,
    Color cardColor,
    Color textColor,
    bool isDark,
  ) {
    if (activities.isEmpty) {
      return Center(
        child: Text(
          'No recent activities',
          style: TextStyle(color: Colors.grey[500]),
        ),
      );
    }

    return DecoratedBox(
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(24),
      ),
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: activities.length,
        separatorBuilder: (c, i) => Divider(
          height: 1,
          color: isDark ? Colors.grey[800] : Colors.grey[100],
        ),
        itemBuilder: (context, index) {
          final activity = activities[index];
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: _lightBlue.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    Icons.notifications_active_outlined,
                    color: _lightBlue,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        activity.message,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: textColor,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        activity.time,
                        style: TextStyle(color: Colors.grey[500], fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildErrorState(BuildContext context, String error) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.error_outline_rounded,
            size: 48,
            color: Colors.redAccent,
          ),
          const SizedBox(height: 16),
          Text(error, style: const TextStyle(color: Colors.redAccent)),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: _controller.loadDashboard,
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }
}
