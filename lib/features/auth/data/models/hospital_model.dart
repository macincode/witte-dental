import 'package:hive/hive.dart';

@HiveType(typeId: 3)
class Hospital extends HiveObject {
  Hospital({
    required this.id,
    required this.name,
    required this.code,
    required this.isMain,
    this.businessId,
    this.patientRegPrefix,
    this.address,
    this.phone,
    this.email,
    this.licenseNumber,
    this.logo,
    this.website,
    this.description,
    this.operatingHours,
    this.services,
    this.establishedYear,
    this.totalBeds,
    this.socialMedia,
    this.status,
    this.settings,
    this.paymentSettings,
    this.whatsappSettings,
    this.notificationSettings,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.hasAccess,
  });

  factory Hospital.fromJson(Map<String, dynamic> json) {
    return Hospital(
      id: json['id'],
      businessId: json['business_id'],
      name: json['name'],
      patientRegPrefix: json['patient_reg_prefix'],
      code: json['code'],
      address: json['address'],
      phone: json['phone'],
      email: json['email'],
      licenseNumber: json['license_number'],
      logo: json['logo'],
      website: json['website'],
      description: json['description'],
      operatingHours: json['operating_hours'],
      services: json['services'],
      establishedYear: json['established_year'],
      totalBeds: json['total_beds'],
      socialMedia: json['social_media'],
      isMain: json['is_main'],
      status: json['status'],
      settings: json['settings'],
      paymentSettings: json['payment_settings'],
      whatsappSettings: json['whatsapp_settings'],
      notificationSettings: json['notification_settings'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      deletedAt: json['deleted_at'],
      hasAccess: json['has_access'],
    );
  }

  @HiveField(0)
  final int id;

  @HiveField(1)
  final int? businessId;

  @HiveField(2)
  final String name;

  @HiveField(3)
  final String? patientRegPrefix;

  @HiveField(4)
  final String code;

  @HiveField(5)
  final Map<String, dynamic>? address;

  @HiveField(6)
  final String? phone;

  @HiveField(7)
  final String? email;

  @HiveField(8)
  final String? licenseNumber;

  @HiveField(19)
  final String? logo;

  @HiveField(20)
  final String? website;

  @HiveField(21)
  final String? description;

  @HiveField(22)
  final Map<String, dynamic>? operatingHours;

  @HiveField(23)
  final List<dynamic>? services;

  @HiveField(24)
  final int? establishedYear;

  @HiveField(25)
  final int? totalBeds;

  @HiveField(26)
  final Map<String, dynamic>? socialMedia;

  @HiveField(9)
  final bool isMain;

  @HiveField(10)
  final String? status;

  @HiveField(11)
  final Map<String, dynamic>? settings;

  @HiveField(12)
  final Map<String, dynamic>? paymentSettings;

  @HiveField(13)
  final Map<String, dynamic>? whatsappSettings;

  @HiveField(14)
  final Map<String, dynamic>? notificationSettings;

  @HiveField(15)
  final String? createdAt;

  @HiveField(16)
  final String? updatedAt;

  @HiveField(17)
  final String? deletedAt;

  @HiveField(18)
  final bool? hasAccess;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'business_id': businessId,
      'name': name,
      'patient_reg_prefix': patientRegPrefix,
      'code': code,
      'address': address,
      'phone': phone,
      'email': email,
      'license_number': licenseNumber,
      'logo': logo,
      'website': website,
      'description': description,
      'operating_hours': operatingHours,
      'services': services,
      'established_year': establishedYear,
      'total_beds': totalBeds,
      'social_media': socialMedia,
      'is_main': isMain,
      'status': status,
      'settings': settings,
      'payment_settings': paymentSettings,
      'whatsapp_settings': whatsappSettings,
      'notification_settings': notificationSettings,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'deleted_at': deletedAt,
      'has_access': hasAccess,
    };
  }
}
