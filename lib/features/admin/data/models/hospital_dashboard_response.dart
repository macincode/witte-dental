class HospitalDashboardResponse {
  final bool status;
  final String message;
  final HospitalDashboardData data;

  HospitalDashboardResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory HospitalDashboardResponse.fromJson(Map<String, dynamic> json) {
    return HospitalDashboardResponse(
      status: json['status'],
      message: json['message'],
      data: HospitalDashboardData.fromJson(json['data']),
    );
  }
}

class HospitalDashboardData {
  final String hospitalId;
  final HospitalStats stats;
  final List<RecentActivity> recentActivities;

  HospitalDashboardData({
    required this.hospitalId,
    required this.stats,
    required this.recentActivities,
  });

  factory HospitalDashboardData.fromJson(Map<String, dynamic> json) {
    return HospitalDashboardData(
      hospitalId: json['hospital_id'],
      stats: HospitalStats.fromJson(json['stats']),
      recentActivities: (json['recent_activities'] as List)
          .map((e) => RecentActivity.fromJson(e))
          .toList(),
    );
  }
}

class HospitalStats {
  final int totalPatients;
  final int todayAppointments;
  final double monthlyRevenue;
  final int monthlyAppointments;
  final int activeStaff;
  final int pendingAppointments;
  final int completedTreatments;
  final StatsTrends trends;

  HospitalStats({
    required this.totalPatients,
    required this.todayAppointments,
    required this.monthlyRevenue,
    required this.monthlyAppointments,
    required this.activeStaff,
    required this.pendingAppointments,
    required this.completedTreatments,
    required this.trends,
  });

  factory HospitalStats.fromJson(Map<String, dynamic> json) {
    return HospitalStats(
      totalPatients: json['total_patients'],
      todayAppointments: json['today_appointments'],
      monthlyRevenue: (json['monthly_revenue'] as num).toDouble(),
      monthlyAppointments: json['monthly_appointments'],
      activeStaff: json['active_staff'],
      pendingAppointments: json['pending_appointments'],
      completedTreatments: json['completed_treatments'],
      trends: StatsTrends.fromJson(json['trends']),
    );
  }
}

class StatsTrends {
  final TrendData patients;
  final TrendData appointments;
  final TrendData revenue;

  StatsTrends({
    required this.patients,
    required this.appointments,
    required this.revenue,
  });

  factory StatsTrends.fromJson(Map<String, dynamic> json) {
    return StatsTrends(
      patients: TrendData.fromJson(json['patients']),
      appointments: TrendData.fromJson(json['appointments']),
      revenue: TrendData.fromJson(json['revenue']),
    );
  }
}

class TrendData {
  final int value;
  final String direction;

  TrendData({
    required this.value,
    required this.direction,
  });

  factory TrendData.fromJson(Map<String, dynamic> json) {
    return TrendData(
      value: json['value'],
      direction: json['direction'],
    );
  }
}

class RecentActivity {
  final String type;
  final String message;
  final String time;
  final String icon;

  RecentActivity({
    required this.type,
    required this.message,
    required this.time,
    required this.icon,
  });

  factory RecentActivity.fromJson(Map<String, dynamic> json) {
    return RecentActivity(
      type: json['type'],
      message: json['message'],
      time: json['time'],
      icon: json['icon'],
    );
  }
}
