import 'package:hive/hive.dart';
import 'package:witte_dental_pms/features/auth/data/models/hospital_model.dart';
import 'package:witte_dental_pms/features/auth/data/models/subscription_model.dart';

@HiveType(typeId: 2)
class Business extends HiveObject {
  Business({
    required this.id,
    required this.name,
    required this.businessType,
    this.organizationId,
    this.slug,
    this.ownerName,
    this.ownerEmail,
    this.ownerPhone,
    this.address,
    this.taxDetails,
    this.status,
    this.trialEndsAt,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.role,
    this.subscription,
    this.hospitals,
  });

  factory Business.fromJson(Map<String, dynamic> json) {
    return Business(
      id: json['id'],
      organizationId: json['organization_id'],
      name: json['name'],
      slug: json['slug'],
      businessType: json['business_type'],
      ownerName: json['owner_name'],
      ownerEmail: json['owner_email'],
      ownerPhone: json['owner_phone'],
      address: json['address'],
      taxDetails: json['tax_details'],
      status: json['status'],
      trialEndsAt: json['trial_ends_at'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      deletedAt: json['deleted_at'],
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

  @HiveField(0)
  final int id;

  @HiveField(1)
  final int? organizationId;

  @HiveField(2)
  final String name;

  @HiveField(3)
  final String? slug;

  @HiveField(4)
  final String businessType;

  @HiveField(5)
  final String? ownerName;

  @HiveField(6)
  final String? ownerEmail;

  @HiveField(7)
  final String? ownerPhone;

  @HiveField(8)
  final Map<String, dynamic>? address;

  @HiveField(9)
  final Map<String, dynamic>? taxDetails;

  @HiveField(10)
  final String? status;

  @HiveField(11)
  final String? trialEndsAt;

  @HiveField(12)
  final String? createdAt;

  @HiveField(13)
  final String? updatedAt;

  @HiveField(14)
  final String? deletedAt;

  @HiveField(15)
  final String? role;

  @HiveField(16)
  final Subscription? subscription;

  @HiveField(17)
  final List<Hospital>? hospitals;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'organization_id': organizationId,
      'name': name,
      'slug': slug,
      'business_type': businessType,
      'owner_name': ownerName,
      'owner_email': ownerEmail,
      'owner_phone': ownerPhone,
      'address': address,
      'tax_details': taxDetails,
      'status': status,
      'trial_ends_at': trialEndsAt,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'deleted_at': deletedAt,
      'role': role,
      'subscription': subscription?.toJson(),
      'hospitals': hospitals?.map((e) => e.toJson()).toList(),
    };
  }
}
