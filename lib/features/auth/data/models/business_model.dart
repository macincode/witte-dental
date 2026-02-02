import 'package:hive/hive.dart';
import 'package:witte_dental_pms/features/auth/data/models/hospital_model.dart';
import 'package:witte_dental_pms/features/auth/data/models/subscription_model.dart';

part 'business_model.g.dart';

@HiveType(typeId: 2)
class Business extends HiveObject {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String businessType;

  @HiveField(3)
  final String role;

  @HiveField(4)
  final Subscription? subscription;

  @HiveField(5)
  final List<Hospital>? hospitals;

  Business({
    required this.id,
    required this.name,
    required this.businessType,
    required this.role,
    this.subscription,
    this.hospitals,
  });

  factory Business.fromJson(Map<String, dynamic> json) {
    return Business(
      id: json['id'],
      name: json['name'],
      businessType: json['business_type'],
      role: json['role'],
      subscription: json['subscription'] != null
          ? Subscription.fromJson(json['subscription'])
          : null,
      hospitals: json['hospitals'] != null
          ? (json['hospitals'] as List)
              .map((e) => Hospital.fromJson(e))
              .toList()
          : null,
    );
  }
}
