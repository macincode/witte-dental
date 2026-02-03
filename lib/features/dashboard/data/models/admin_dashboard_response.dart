import 'package:json_annotation/json_annotation.dart';
import 'package:witte_dental_pms/features/auth/data/models/business_model.dart';
import 'package:witte_dental_pms/features/auth/data/models/hospital_model.dart';

@JsonSerializable()
class AdminDashboardResponse {
  final bool success;
  final AdminDashboardData data;

  AdminDashboardResponse({
    required this.success,
    required this.data,
  });

  factory AdminDashboardResponse.fromJson(Map<String, dynamic> json) {
    return AdminDashboardResponse(
      success: json['success'],
      data: AdminDashboardData.fromJson(json['data']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'data': data.toJson(),
    };
  }
}

@JsonSerializable()
class AdminDashboardData {
  final Business business;
  final DashboardStats stats;
  final List<Hospital> hospitals;

  AdminDashboardData({
    required this.business,
    required this.stats,
    required this.hospitals,
  });

  factory AdminDashboardData.fromJson(Map<String, dynamic> json) {
    return AdminDashboardData(
      business: Business.fromJson(json['business']),
      stats: DashboardStats.fromJson(json['stats']),
      hospitals:
          (json['hospitals'] as List).map((e) => Hospital.fromJson(e)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'business': business.toJson(),
      'stats': stats.toJson(),
      'hospitals': hospitals.map((e) => e.toJson()).toList(),
    };
  }
}

@JsonSerializable()
class DashboardStats {
  @JsonKey(name: 'total_hospitals')
  final int totalHospitals;
  @JsonKey(name: 'total_patients')
  final int totalPatients;
  @JsonKey(name: 'total_staff')
  final int totalStaff;
  @JsonKey(name: 'appointments_today')
  final int appointmentsToday;

  DashboardStats({
    required this.totalHospitals,
    required this.totalPatients,
    required this.totalStaff,
    required this.appointmentsToday,
  });

  factory DashboardStats.fromJson(Map<String, dynamic> json) {
    return DashboardStats(
      totalHospitals: json['total_hospitals'] ?? 0,
      totalPatients: json['total_patients'] ?? 0,
      totalStaff: json['total_staff'] ?? 0,
      appointmentsToday: json['appointments_today'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'total_hospitals': totalHospitals,
      'total_patients': totalPatients,
      'total_staff': totalStaff,
      'appointments_today': appointmentsToday,
    };
  }
}
