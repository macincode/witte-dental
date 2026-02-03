import 'package:hive/hive.dart';

@HiveType(typeId: 4)
class Subscription extends HiveObject {
  Subscription({
    required this.status,
    this.id,
    this.businessId,
    this.planId,
    this.razorpaySubscriptionId,
    this.currentPeriodStart,
    this.currentPeriodEnd,
    this.trialEndsAt,
    this.canceledAt,
    this.createdAt,
    this.updatedAt,
    this.plan,
    // Legacy fields for backward compatibility
    this.planName,
  });

  factory Subscription.fromJson(Map<String, dynamic> json) {
    return Subscription(
      id: json['id'],
      businessId: json['business_id'],
      planId: json['plan_id'],
      razorpaySubscriptionId: json['razorpay_subscription_id'],
      status: json['status'],
      currentPeriodStart: json['current_period_start'],
      currentPeriodEnd: json['current_period_end'],
      trialEndsAt: json['trial_ends_at'],
      canceledAt: json['canceled_at'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      plan:
          json['plan'] != null ? SubscriptionPlan.fromJson(json['plan']) : null,
      planName: json['plan_name'],
    );
  }

  @HiveField(0)
  final int? id;

  @HiveField(1)
  final int? businessId;

  @HiveField(2)
  final int? planId;

  @HiveField(3)
  final String? razorpaySubscriptionId;

  @HiveField(4)
  final String status;

  @HiveField(5)
  final String? currentPeriodStart;

  @HiveField(6)
  final String? currentPeriodEnd;

  @HiveField(7)
  final String? trialEndsAt;

  @HiveField(8)
  final String? canceledAt;

  @HiveField(9)
  final String? createdAt;

  @HiveField(10)
  final String? updatedAt;

  @HiveField(11)
  final SubscriptionPlan? plan;

  @HiveField(12)
  final String? planName;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'business_id': businessId,
      'plan_id': planId,
      'razorpay_subscription_id': razorpaySubscriptionId,
      'status': status,
      'current_period_start': currentPeriodStart,
      'current_period_end': currentPeriodEnd,
      'trial_ends_at': trialEndsAt,
      'canceled_at': canceledAt,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'plan': plan?.toJson(),
      'plan_name': planName,
    };
  }
}

@HiveType(typeId: 5)
class SubscriptionPlan extends HiveObject {
  SubscriptionPlan({
    required this.id,
    required this.name,
    required this.slug,
    required this.description,
    required this.price,
    required this.billingCycle,
    required this.features,
    required this.limits,
    required this.isActive,
    this.razorpayPlanId,
    this.createdAt,
    this.updatedAt,
  });

  factory SubscriptionPlan.fromJson(Map<String, dynamic> json) {
    return SubscriptionPlan(
      id: json['id'],
      name: json['name'],
      slug: json['slug'],
      description: json['description'],
      price: json['price'],
      billingCycle: json['billing_cycle'],
      features: List<String>.from(json['features']),
      limits: Map<String, dynamic>.from(json['limits']),
      razorpayPlanId: json['razorpay_plan_id'],
      isActive: json['is_active'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  @HiveField(0)
  final int id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String slug;

  @HiveField(3)
  final String description;

  @HiveField(4)
  final String price;

  @HiveField(5)
  final String billingCycle;

  @HiveField(6)
  final List<String> features;

  @HiveField(7)
  final Map<String, dynamic> limits;

  @HiveField(8)
  final String? razorpayPlanId;

  @HiveField(9)
  final bool isActive;

  @HiveField(10)
  final String? createdAt;

  @HiveField(11)
  final String? updatedAt;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'slug': slug,
      'description': description,
      'price': price,
      'billing_cycle': billingCycle,
      'features': features,
      'limits': limits,
      'razorpay_plan_id': razorpayPlanId,
      'is_active': isActive,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}
