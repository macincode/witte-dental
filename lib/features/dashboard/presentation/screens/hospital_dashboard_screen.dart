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
                    _buildHospitalInfoCard(
                      context,
                      widget.hospitalId,
                      widget.hospitalName,
                      cardColor,
                      textColor,
                      isDark,
                    ),
                    const SizedBox(height: 20),
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
                            data.paymentStats.collectionRate / 100,
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
    final ageGroups = demographics.ageGroups;

    if (male.count == 0 && female.count == 0 && ageGroups.isEmpty) {
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
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(24),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Age Distribution
          if (ageGroups.isNotEmpty) ...[
            Text(
              'Age Distribution',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: textColor,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 16),
            ...ageGroups.map((age) {
              final colors = [_primaryBlue, _lightBlue, _purple, _orange];
              final color = colors[ageGroups.indexOf(age) % colors.length];
              return Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  children: [
                    Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        color: color,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      age.range,
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 12,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      '${age.count} (${age.percentage.toStringAsFixed(1)}%)',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: textColor,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              );
            }),
            const SizedBox(height: 20),
          ],
          // Gender Distribution
          if (male.count > 0 || female.count > 0) ...[
            Text(
              'Gender Distribution',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: textColor,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: _primaryBlue.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        Text(
                          male.count.toString(),
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: _primaryBlue,
                          ),
                        ),
                        Text(
                          'Male (${male.percentage.toStringAsFixed(1)}%)',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFF6B6B).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        Text(
                          female.count.toString(),
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFFF6B6B),
                          ),
                        ),
                        Text(
                          'Female (${female.percentage.toStringAsFixed(1)}%)',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
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

  Widget _buildKeyMetricsGrid(
    BuildContext context,
    HospitalStats stats,
    Color cardColor,
    Color textColor,
    bool isDark,
  ) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      childAspectRatio: 1.2,
      children: [
        _buildMetricCard(
          'Total Patients',
          stats.totalPatients.toString(),
          '${stats.trends.patients.value}% from last month',
          stats.trends.patients.direction,
          Icons.people_alt_rounded,
          _lightBlue,
          cardColor,
          textColor,
          isDark,
        ),
        _buildMetricCard(
          'Appointments',
          '${stats.todayAppointments}/${stats.monthlyAppointments}',
          'Today / This Month',
          'flat',
          Icons.calendar_today_rounded,
          _purple,
          cardColor,
          textColor,
          isDark,
        ),
        _buildMetricCard(
          'Monthly Revenue',
          '₹${(stats.monthlyRevenue / 1000).toStringAsFixed(0)}k',
          '${stats.trends.revenue.value}% from last month',
          stats.trends.revenue.direction,
          Icons.currency_rupee_rounded,
          const Color(0xFF00C853),
          cardColor,
          textColor,
          isDark,
        ),
        _buildMetricCard(
          'Active Staff',
          stats.activeStaff.toString(),
          'Currently on duty',
          'flat',
          Icons.medical_services_rounded,
          _orange,
          cardColor,
          textColor,
          isDark,
        ),
      ],
    );
  }

  Widget _buildMetricCard(
    String title,
    String value,
    String subtitle,
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
        : (trend == 'down' ? Icons.trending_down : null);
    final trendColor =
        isUp ? Colors.green : (trend == 'down' ? Colors.red : null);

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
              if (trendIcon != null)
                Icon(trendIcon, color: trendColor, size: 20),
            ],
          ),
          const Spacer(),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: isDark ? Colors.grey[400] : Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 10,
              color: isDark ? Colors.grey[500] : Colors.grey[500],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopTreatmentsCard(
    BuildContext context,
    List<TopTreatment> treatments,
    Color cardColor,
    Color textColor,
    bool isDark,
  ) {
    if (treatments.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: const Center(child: Text('No treatment data available')),
      );
    }

    final colors = [_primaryBlue, _lightBlue, _purple, _orange, Colors.green];

    return Container(
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
        children: treatments.take(5).map((treatment) {
          final index = treatments.indexOf(treatment);
          final color = colors[index % colors.length];
          return Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Row(
              children: [
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: color,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      '${index + 1}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        treatment.name,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: textColor,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        '${treatment.count} procedures',
                        style: TextStyle(
                          color: isDark ? Colors.grey[400] : Colors.grey[600],
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  '₹${(treatment.revenue / 1000).toStringAsFixed(0)}k Revenue',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: color,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildDoctorPerformanceCard(
    BuildContext context,
    List<DoctorPerformance> doctors,
    Color cardColor,
    Color textColor,
    bool isDark,
  ) {
    if (doctors.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: const Center(child: Text('No doctor performance data')),
      );
    }

    return Container(
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
        children: doctors.map((doctor) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundColor: _primaryBlue.withOpacity(0.1),
                  child: Text(
                    doctor.name.split(' ').map((n) => n[0]).take(2).join(),
                    style: TextStyle(
                      color: _primaryBlue,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        doctor.name,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: textColor,
                          fontSize: 14,
                        ),
                      ),
                      Row(
                        children: [
                          const Icon(Icons.star, color: Colors.amber, size: 14),
                          const SizedBox(width: 4),
                          Text(
                            doctor.rating.toStringAsFixed(1),
                            style: TextStyle(
                              color:
                                  isDark ? Colors.grey[400] : Colors.grey[600],
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Text(
                            '${doctor.patientsTreated} patients',
                            style: TextStyle(
                              color:
                                  isDark ? Colors.grey[400] : Colors.grey[600],
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Text(
                  '₹${(doctor.revenue / 100000).toStringAsFixed(1)}L',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildRetentionCard(
    BuildContext context,
    PatientRetention retention,
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
          Text(
            '${retention.retentionRate.toStringAsFixed(0)}%',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
          Text(
            'Retention Rate',
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Text(
                    retention.newPatientsThisMonth.toString(),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: _lightBlue,
                    ),
                  ),
                  Text(
                    'New Patients',
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Text(
                    retention.returningPatients.toString(),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                  Text(
                    'Returning',
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentCard(
    BuildContext context,
    PaymentStats payment,
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
          Text(
            '${payment.collectionRate.toStringAsFixed(0)}%',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
          Text(
            'Collection Rate',
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Text(
                    '₹${(payment.collectedThisMonth / 1000).toStringAsFixed(0)}k',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                  Text(
                    'Collected',
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Text(
                    '₹${(payment.pendingPayments / 100000).toStringAsFixed(1)}L',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
                  Text(
                    'Pending',
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPeakHoursCard(
    BuildContext context,
    List<PeakHour> peakHours,
    Color cardColor,
    Color textColor,
    bool isDark,
  ) {
    if (peakHours.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: const Center(child: Text('No peak hours data')),
      );
    }

    final maxAppointments =
        peakHours.map((h) => h.appointments).reduce((a, b) => a > b ? a : b);

    return Container(
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
        children: peakHours.map((hour) {
          final percentage = hour.appointments / maxAppointments;
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Row(
              children: [
                SizedBox(
                  width: 80,
                  child: Text(
                    hour.time,
                    style: TextStyle(
                      fontSize: 12,
                      color: isDark ? Colors.grey[400] : Colors.grey[600],
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Container(
                    height: 8,
                    decoration: BoxDecoration(
                      color: isDark ? Colors.grey[800] : Colors.grey[200],
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: FractionallySizedBox(
                      alignment: Alignment.centerLeft,
                      widthFactor: percentage,
                      child: Container(
                        decoration: BoxDecoration(
                          color: _primaryBlue,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  hour.appointments.toString(),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: textColor,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildHospitalInfoCard(
    BuildContext context,
    int hospitalId,
    String hospitalName,
    Color cardColor,
    Color textColor,
    bool isDark,
  ) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: LinearGradient(
          colors: [_primaryBlue, _lightBlue],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: _primaryBlue.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            right: -20,
            top: -20,
            child: Icon(
              Icons.local_hospital,
              size: 150,
              color: Colors.white.withOpacity(0.1),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text(
                        'HOSPITAL DASHBOARD',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.greenAccent.shade400,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Row(
                        children: [
                          Icon(Icons.check_circle,
                              size: 12, color: Colors.black87),
                          SizedBox(width: 4),
                          Text(
                            'ACTIVE',
                            style: TextStyle(
                              color: Colors.black87,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Text(
                  hospitalName,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.location_on_outlined,
                        color: Colors.white70, size: 16),
                    const SizedBox(width: 6),
                    Text(
                      'Hospital ID: #$hospitalId',
                      style:
                          const TextStyle(color: Colors.white70, fontSize: 14),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Divider(color: Colors.white.withOpacity(0.2)),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'OPERATIONAL STATUS',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.6),
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 2),
                        const Text(
                          'Fully Operational',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'LAST UPDATED',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.6),
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 2),
                        const Text(
                          'Just now',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
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
