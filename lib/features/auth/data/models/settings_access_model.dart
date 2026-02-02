import 'package:hive/hive.dart';

part 'settings_access_model.g.dart';

@HiveType(typeId: 5)
class SettingsAccess extends HiveObject {
  @HiveField(0)
  final bool saasManagement;

  @HiveField(1)
  final bool businessManagement;

  @HiveField(2)
  final bool hospitalManagement;

  @HiveField(3)
  final bool subscriptionManagement;

  @HiveField(4)
  final bool teamManagement;

  @HiveField(5)
  final bool membershipPlans;

  SettingsAccess({
    required this.saasManagement,
    required this.businessManagement,
    required this.hospitalManagement,
    required this.subscriptionManagement,
    required this.teamManagement,
    required this.membershipPlans,
  });

  factory SettingsAccess.fromJson(Map<String, dynamic> json) {
    return SettingsAccess(
      saasManagement: json['saas_management'],
      businessManagement: json['business_management'],
      hospitalManagement: json['hospital_management'],
      subscriptionManagement: json['subscription_management'],
      teamManagement: json['team_management'],
      membershipPlans: json['membership_plans'],
    );
  }
}
