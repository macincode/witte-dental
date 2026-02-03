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
