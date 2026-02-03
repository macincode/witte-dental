class StaffListResponse {
  StaffListResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory StaffListResponse.fromJson(Map<String, dynamic> json) {
    return StaffListResponse(
      status: json['status'] ?? false,
      message: json['message'] ?? '',
      data:
          (json['data'] as List?)?.map((e) => Staff.fromJson(e)).toList() ?? [],
    );
  }

  final bool status;
  final String message;
  final List<Staff> data;
}

class Staff {
  Staff({
    required this.id,
    required this.staffCategory,
    required this.staffCategoryId,
    required this.qualification,
    required this.employeeNumber,
    required this.aadharNumber,
    required this.roleId,
    required this.roleName,
    required this.firstName,
    required this.surname,
    required this.email,
    required this.phone,
    required this.dob,
    required this.age,
    required this.gender,
    required this.image,
    required this.address,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Staff.fromJson(Map<String, dynamic> json) {
    return Staff(
      id: json['id'] ?? 0,
      staffCategory: json['staff_category'] ?? '',
      staffCategoryId: json['staff_category_id'] ?? 0,
      qualification: json['qualification'] ?? '',
      employeeNumber: json['employee_number'],
      aadharNumber: json['aadhar_number'],
      roleId: json['role_id'] ?? 0,
      roleName: json['role_name'] ?? '',
      firstName: json['first_name'] ?? '',
      surname: json['surname'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      dob: json['dob'] ?? '',
      age: json['age'] ?? 0,
      gender: json['gender'] ?? '',
      image: json['image'] ?? '',
      address: json['address'] ?? '',
      status: json['status'] ?? 0,
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
    );
  }

  final int id;
  final String staffCategory;
  final int staffCategoryId;
  final String qualification;
  final dynamic employeeNumber; // nullable
  final dynamic aadharNumber; // nullable
  final int roleId;
  final String roleName;
  final String firstName;
  final String surname;
  final String email;
  final String phone;
  final String dob;
  final int age;
  final String gender;
  final String image;
  final String address;
  final int status;
  final String createdAt;
  final String updatedAt;

  String get fullName => '$firstName $surname';
}
