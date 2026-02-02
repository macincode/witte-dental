import 'package:hive/hive.dart';
import 'package:witte_dental_pms/features/auth/data/models/business_model.dart';
import 'package:witte_dental_pms/features/auth/data/models/hospital_model.dart';
import 'package:witte_dental_pms/features/auth/data/models/settings_access_model.dart';
import 'package:witte_dental_pms/features/auth/data/models/user_model.dart';

part 'admin_login_response.g.dart';

@HiveType(typeId: 0)
class AdminLoginResponse extends HiveObject {
  @HiveField(0)
  final bool success;

  @HiveField(1)
  final String message;

  @HiveField(2)
  final String userType;

  @HiveField(3)
  final User? data;

  @HiveField(4)
  final String? token;

  @HiveField(5)
  final List<Business>? businesses;

  @HiveField(6)
  final Business? currentBusiness;

  @HiveField(7)
  final Hospital? currentHospital;

  @HiveField(8)
  final SettingsAccess? settingsAccess;

  AdminLoginResponse({
    required this.success,
    required this.message,
    required this.userType,
    this.data,
    this.token,
    this.businesses,
    this.currentBusiness,
    this.currentHospital,
    this.settingsAccess,
  });

  factory AdminLoginResponse.fromJson(Map<String, dynamic> json) {
    return AdminLoginResponse(
      success: json['success'],
      message: json['message'],
      userType: json['user_type'],
      data: json['data'] != null ? User.fromJson(json['data']) : null,
      token: json['token'],
      businesses: json['businesses'] != null
          ? (json['businesses'] as List)
              .map((e) => Business.fromJson(e))
              .toList()
          : null,
      currentBusiness: json['current_business'] != null
          ? Business.fromJson(json['current_business'])
          : null,
      currentHospital: json['current_hospital'] != null
          ? Hospital.fromJson(json['current_hospital'])
          : null,
      settingsAccess: json['settings_access'] != null
          ? SettingsAccess.fromJson(json['settings_access'])
          : null,
    );
  }
}
