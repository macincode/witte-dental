import 'package:hive/hive.dart';

part 'subscription_model.g.dart';

@HiveType(typeId: 4)
class Subscription extends HiveObject {
  @HiveField(0)
  final String planName;

  @HiveField(1)
  final String status;

  @HiveField(2)
  final String? trialEndsAt;

  Subscription({
    required this.planName,
    required this.status,
    this.trialEndsAt,
  });

  factory Subscription.fromJson(Map<String, dynamic> json) {
    return Subscription(
      planName: json['plan_name'],
      status: json['status'],
      trialEndsAt: json['trial_ends_at'],
    );
  }
}
