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
}

class AdminDashboardData {
  final BusinessInfo business;
  final DashboardStats stats;
  final List<HospitalInfo> hospitals;

  AdminDashboardData({
    required this.business,
    required this.stats,
    required this.hospitals,
  });

  factory AdminDashboardData.fromJson(Map<String, dynamic> json) {
    return AdminDashboardData(
      business: BusinessInfo.fromJson(json['business']),
      stats: DashboardStats.fromJson(json['stats']),
      hospitals: (json['hospitals'] as List)
          .map((e) => HospitalInfo.fromJson(e))
          .toList(),
    );
  }
}

class BusinessInfo {
  final int id;
  final String name;
  final String businessType;
  final String ownerName;
  final List<HospitalInfo> hospitals;

  BusinessInfo({
    required this.id,
    required this.name,
    required this.businessType,
    required this.ownerName,
    required this.hospitals,
  });

  factory BusinessInfo.fromJson(Map<String, dynamic> json) {
    return BusinessInfo(
      id: json['id'],
      name: json['name'],
      businessType: json['business_type'],
      ownerName: json['owner_name'],
      hospitals: (json['hospitals'] as List)
          .map((e) => HospitalInfo.fromJson(e))
          .toList(),
    );
  }
}

class HospitalInfo {
  final int id;
  final String name;
  final String code;
  final String phone;
  final String email;
  final bool isMain;
  final String status;

  HospitalInfo({
    required this.id,
    required this.name,
    required this.code,
    required this.phone,
    required this.email,
    required this.isMain,
    required this.status,
  });

  factory HospitalInfo.fromJson(Map<String, dynamic> json) {
    return HospitalInfo(
      id: json['id'],
      name: json['name'],
      code: json['code'],
      phone: json['phone'],
      email: json['email'],
      isMain: json['is_main'],
      status: json['status'],
    );
  }
}

class DashboardStats {
  final int totalHospitals;
  final int totalPatients;
  final int totalStaff;
  final int appointmentsToday;

  DashboardStats({
    required this.totalHospitals,
    required this.totalPatients,
    required this.totalStaff,
    required this.appointmentsToday,
  });

  factory DashboardStats.fromJson(Map<String, dynamic> json) {
    return DashboardStats(
      totalHospitals: json['total_hospitals'],
      totalPatients: json['total_patients'],
      totalStaff: json['total_staff'],
      appointmentsToday: json['appointments_today'],
    );
  }
}
