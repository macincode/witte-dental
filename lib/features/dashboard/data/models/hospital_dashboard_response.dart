class HospitalDashboardResponse {
  HospitalDashboardResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory HospitalDashboardResponse.fromJson(Map<String, dynamic> json) {
    return HospitalDashboardResponse(
      status: json['status'] ?? false,
      message: json['message'] ?? '',
      data: HospitalDashboardData.fromJson(json['data'] ?? {}),
    );
  }
  final bool status;
  final String message;
  final HospitalDashboardData data;
}

class HospitalDashboardData {
  HospitalDashboardData({
    required this.hospitalId,
    required this.stats,
    required this.todayAppointments,
    required this.upcomingAppointments,
    required this.recentActivities,
    required this.calendarData,
    required this.revenueChart,
    required this.quickStats,
    required this.topTreatments,
    required this.doctorPerformance,
    required this.patientRetention,
    required this.paymentStats,
    required this.peakHours,
    required this.delayStats,
    required this.meta,
  });

  factory HospitalDashboardData.fromJson(Map<String, dynamic> json) {
    return HospitalDashboardData(
      hospitalId: json['hospital_id']?.toString() ?? '',
      stats: HospitalStats.fromJson(json['stats'] ?? {}),
      todayAppointments: json['today_appointments'] ?? [],
      upcomingAppointments: json['upcoming_appointments'] ?? [],
      recentActivities: (json['recent_activities'] as List?)
              ?.map((e) => RecentActivity.fromJson(e))
              .toList() ??
          [],
      calendarData: CalendarData.fromJson(json['calendar_data'] ?? {}),
      revenueChart: RevenueChart.fromJson(json['revenue_chart'] ?? {}),
      quickStats: QuickStats.fromJson(json['quick_stats'] ?? {}),
      topTreatments: (json['top_treatments'] as List?)
              ?.map((e) => TopTreatment.fromJson(e))
              .toList() ??
          [],
      doctorPerformance: (json['doctor_performance'] as List?)
              ?.map((e) => DoctorPerformance.fromJson(e))
              .toList() ??
          [],
      patientRetention:
          PatientRetention.fromJson(json['patient_retention'] ?? {}),
      paymentStats: PaymentStats.fromJson(json['payment_stats'] ?? {}),
      peakHours: (json['peak_hours'] as List?)
              ?.map((e) => PeakHour.fromJson(e))
              .toList() ??
          [],
      delayStats: DelayStats.fromJson(json['delay_stats'] ?? {}),
      meta: Meta.fromJson(json['meta'] ?? {}),
    );
  }
  final String hospitalId;
  final HospitalStats stats;
  final List<dynamic> todayAppointments;
  final List<dynamic> upcomingAppointments;
  final List<RecentActivity> recentActivities;
  final CalendarData calendarData;
  final RevenueChart revenueChart;
  final QuickStats quickStats;
  final List<TopTreatment> topTreatments;
  final List<DoctorPerformance> doctorPerformance;
  final PatientRetention patientRetention;
  final PaymentStats paymentStats;
  final List<PeakHour> peakHours;
  final DelayStats delayStats;
  final Meta meta;
}

class HospitalStats {
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
      totalPatients: json['total_patients'] ?? 0,
      todayAppointments: json['today_appointments'] ?? 0,
      monthlyRevenue: (json['monthly_revenue'] ?? 0).toDouble(),
      monthlyAppointments: json['monthly_appointments'] ?? 0,
      activeStaff: json['active_staff'] ?? 0,
      pendingAppointments: json['pending_appointments'] ?? 0,
      completedTreatments: json['completed_treatments'] ?? 0,
      trends: Trends.fromJson(json['trends'] ?? {}),
    );
  }
  final int totalPatients;
  final int todayAppointments;
  final double monthlyRevenue;
  final int monthlyAppointments;
  final int activeStaff;
  final int pendingAppointments;
  final int completedTreatments;
  final Trends trends;
}

class Trends {
  Trends({
    required this.patients,
    required this.appointments,
    required this.revenue,
  });

  factory Trends.fromJson(Map<String, dynamic> json) {
    return Trends(
      patients: TrendData.fromJson(json['patients'] ?? {}),
      appointments: TrendData.fromJson(json['appointments'] ?? {}),
      revenue: TrendData.fromJson(json['revenue'] ?? {}),
    );
  }
  final TrendData patients;
  final TrendData appointments;
  final TrendData revenue;
}

class TrendData {
  TrendData({
    required this.value,
    required this.direction,
  });

  factory TrendData.fromJson(Map<String, dynamic> json) {
    return TrendData(
      value: json['value'] ?? 0,
      direction: json['direction'] ?? 'up',
    );
  }
  final int value;
  final String direction;
}

class RecentActivity {
  RecentActivity({
    required this.type,
    required this.message,
    required this.time,
    required this.icon,
  });

  factory RecentActivity.fromJson(Map<String, dynamic> json) {
    return RecentActivity(
      type: json['type'] ?? '',
      message: json['message'] ?? '',
      time: json['time'] ?? '',
      icon: json['icon'] ?? '',
    );
  }
  final String type;
  final String message;
  final String time;
  final String icon;
}

class CalendarData {
  CalendarData({
    required this.currentMonth,
    required this.appointmentsByDate,
  });

  factory CalendarData.fromJson(Map<String, dynamic> json) {
    return CalendarData(
      currentMonth: json['current_month'] ?? '',
      appointmentsByDate: json['appointments_by_date'] ?? [],
    );
  }
  final String currentMonth;
  final List<dynamic> appointmentsByDate;
}

class RevenueChart {
  RevenueChart({
    required this.monthlyData,
    required this.totalRevenue,
    required this.growthPercentage,
  });

  factory RevenueChart.fromJson(Map<String, dynamic> json) {
    return RevenueChart(
      monthlyData: (json['monthly_data'] as List?)
              ?.map((e) => MonthlyData.fromJson(e))
              .toList() ??
          [],
      totalRevenue: (json['total_revenue'] ?? 0).toDouble(),
      growthPercentage: (json['growth_percentage'] ?? 0).toDouble(),
    );
  }
  final List<MonthlyData> monthlyData;
  final double totalRevenue;
  final double growthPercentage;
}

class MonthlyData {
  MonthlyData({
    required this.month,
    required this.revenue,
    required this.appointments,
  });

  factory MonthlyData.fromJson(Map<String, dynamic> json) {
    return MonthlyData(
      month: json['month'] ?? '',
      revenue: (json['revenue'] ?? 0).toDouble(),
      appointments: json['appointments'] ?? 0,
    );
  }
  final String month;
  final double revenue;
  final int appointments;
}

class QuickStats {
  QuickStats({
    required this.patientDemographics,
    required this.popularTreatments,
  });

  factory QuickStats.fromJson(Map<String, dynamic> json) {
    return QuickStats(
      patientDemographics:
          PatientDemographics.fromJson(json['patient_demographics'] ?? {}),
      popularTreatments: (json['popular_treatments'] as List?)
              ?.map((e) => PopularTreatment.fromJson(e))
              .toList() ??
          [],
    );
  }
  final PatientDemographics patientDemographics;
  final List<PopularTreatment> popularTreatments;
}

class PatientDemographics {
  PatientDemographics({
    required this.ageGroups,
    required this.genderDistribution,
  });

  factory PatientDemographics.fromJson(Map<String, dynamic> json) {
    return PatientDemographics(
      ageGroups: (json['age_groups'] as List?)
              ?.map((e) => AgeGroup.fromJson(e))
              .toList() ??
          [],
      genderDistribution:
          GenderDistribution.fromJson(json['gender_distribution'] ?? {}),
    );
  }
  final List<AgeGroup> ageGroups;
  final GenderDistribution genderDistribution;
}

class GenderDistribution {
  GenderDistribution({
    required this.male,
    required this.female,
  });

  factory GenderDistribution.fromJson(Map<String, dynamic> json) {
    return GenderDistribution(
      male: GenderData.fromJson(json['male'] ?? {}),
      female: GenderData.fromJson(json['female'] ?? {}),
    );
  }
  final GenderData male;
  final GenderData female;
}

class GenderData {
  GenderData({
    required this.count,
    required this.percentage,
  });

  factory GenderData.fromJson(Map<String, dynamic> json) {
    return GenderData(
      count: json['count'] ?? 0,
      percentage: (json['percentage'] ?? 0).toDouble(),
    );
  }
  final int count;
  final double percentage;
}

class PatientRetention {
  PatientRetention({
    required this.newPatientsThisMonth,
    required this.returningPatients,
    required this.retentionRate,
  });

  factory PatientRetention.fromJson(Map<String, dynamic> json) {
    return PatientRetention(
      newPatientsThisMonth: json['new_patients_this_month'] ?? 0,
      returningPatients: json['returning_patients'] ?? 0,
      retentionRate: (json['retention_rate'] ?? 0).toDouble(),
    );
  }
  final int newPatientsThisMonth;
  final int returningPatients;
  final double retentionRate;
}

class PaymentStats {
  PaymentStats({
    required this.collectedThisMonth,
    required this.pendingPayments,
    required this.collectionRate,
  });

  factory PaymentStats.fromJson(Map<String, dynamic> json) {
    return PaymentStats(
      collectedThisMonth: (json['collected_this_month'] ?? 0).toDouble(),
      pendingPayments: (json['pending_payments'] ?? 0).toDouble(),
      collectionRate: (json['collection_rate'] ?? 0).toDouble(),
    );
  }
  final double collectedThisMonth;
  final double pendingPayments;
  final double collectionRate;
}

class AgeGroup {
  AgeGroup({
    required this.range,
    required this.count,
    required this.percentage,
  });

  factory AgeGroup.fromJson(Map<String, dynamic> json) {
    return AgeGroup(
      range: json['range'] ?? '',
      count: json['count'] ?? 0,
      percentage: (json['percentage'] ?? 0).toDouble(),
    );
  }
  final String range;
  final int count;
  final double percentage;
}

class PopularTreatment {
  PopularTreatment({
    required this.name,
    required this.count,
    required this.percentage,
  });

  factory PopularTreatment.fromJson(Map<String, dynamic> json) {
    return PopularTreatment(
      name: json['name'] ?? '',
      count: json['count'] ?? 0,
      percentage: (json['percentage'] ?? 0).toDouble(),
    );
  }
  final String name;
  final int count;
  final double percentage;
}

class TopTreatment {
  TopTreatment({
    required this.name,
    required this.count,
    required this.revenue,
  });

  factory TopTreatment.fromJson(Map<String, dynamic> json) {
    return TopTreatment(
      name: json['name'] ?? '',
      count: json['count'] ?? 0,
      revenue: (json['revenue'] ?? 0).toDouble(),
    );
  }
  final String name;
  final int count;
  final double revenue;
}

class DoctorPerformance {
  DoctorPerformance({
    required this.name,
    required this.patientsTreated,
    required this.revenue,
    required this.rating,
  });

  factory DoctorPerformance.fromJson(Map<String, dynamic> json) {
    return DoctorPerformance(
      name: json['name'] ?? '',
      patientsTreated: json['patients_treated'] ?? 0,
      revenue: (json['revenue'] ?? 0).toDouble(),
      rating: (json['rating'] ?? 0).toDouble(),
    );
  }
  final String name;
  final int patientsTreated;
  final double revenue;
  final double rating;
}

class PeakHour {
  PeakHour({
    required this.time,
    required this.appointments,
  });

  factory PeakHour.fromJson(Map<String, dynamic> json) {
    return PeakHour(
      time: json['time'] ?? '',
      appointments: json['appointments'] ?? 0,
    );
  }
  final String time;
  final int appointments;
}

class DelayStats {
  DelayStats({
    required this.totalAppointments,
    required this.delayedAppointments,
    required this.avgDelayMinutes,
    required this.onTimePercentage,
  });

  factory DelayStats.fromJson(Map<String, dynamic> json) {
    return DelayStats(
      totalAppointments: json['total_appointments'] ?? 0,
      delayedAppointments: json['delayed_appointments'] ?? 0,
      avgDelayMinutes: json['avg_delay_minutes'] ?? 0,
      onTimePercentage: json['on_time_percentage'] ?? 100,
    );
  }
  final int totalAppointments;
  final int delayedAppointments;
  final int avgDelayMinutes;
  final int onTimePercentage;
}

class Meta {
  Meta({
    required this.lastUpdated,
    required this.refreshInterval,
    required this.timezone,
  });

  factory Meta.fromJson(Map<String, dynamic> json) {
    return Meta(
      lastUpdated: json['last_updated'] ?? '',
      refreshInterval: json['refresh_interval'] ?? 300,
      timezone: json['timezone'] ?? 'UTC',
    );
  }
  final String lastUpdated;
  final int refreshInterval;
  final String timezone;
}
