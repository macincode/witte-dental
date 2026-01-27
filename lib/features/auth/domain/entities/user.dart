class User {

  const User({
    required this.id,
    required this.email,
    required this.name,
    required this.role,
    required this.isActive, required this.createdAt, this.phone,
    this.profileImage,
    this.lastLoginAt,
  });
  final String id;
  final String email;
  final String name;
  final String role;
  final String? phone;
  final String? profileImage;
  final bool isActive;
  final DateTime createdAt;
  final DateTime? lastLoginAt;

  bool get isDoctor => role == 'doctor';
  bool get isPatient => role == 'patient';
  bool get isAdmin => role == 'admin';
  bool get isStaff => role == 'staff';
}