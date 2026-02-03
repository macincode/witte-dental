import 'package:hive/hive.dart';
import 'package:witte_dental_pms/features/auth/data/models/settings_access_model.dart';
import 'package:witte_dental_pms/features/auth/data/models/user_model.dart';

part 'admin_login_response.g.dart';

@HiveType(typeId: 0)
class AdminLoginResponse extends HiveObject {
  AdminLoginResponse({
    required this.message,
    this.success,
    this.status,
    this.userType,
    this.data,
    this.token,
    this.settingsAccess,
    // Non-Hive fields
    this.businesses,
    this.currentBusiness,
    this.currentHospital,
  });

  factory AdminLoginResponse.fromJson(Map<String, dynamic> json) {
    return AdminLoginResponse(
      success: json['success'],
      status: json['status'],
      message: json['message'],
      userType: json['user_type'],
      data: json['data'] != null ? User.fromJson(json['data']) : null,
      token: json['token'],
      settingsAccess: json['settings_access'] != null
          ? SettingsAccess.fromJson(json['settings_access'])
          : null,
      businesses: json['businesses'],
      currentBusiness: json['current_business'],
      currentHospital: json['current_hospital'],
    );
  }

  @HiveField(0)
  final bool? success;

  @HiveField(1)
  final bool? status;

  @HiveField(2)
  final String message;

  @HiveField(3)
  final String? userType;

  @HiveField(4)
  final User? data;

  @HiveField(5)
  final String? token;

  @HiveField(6)
  final SettingsAccess? settingsAccess;

  // Non-Hive fields for API compatibility (stored as dynamic to avoid adapter issues)
  final List<dynamic>? businesses;
  final dynamic currentBusiness;
  final dynamic currentHospital;
}
