class PatientListResponse {
  PatientListResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory PatientListResponse.fromJson(Map<String, dynamic> json) {
    return PatientListResponse(
      status: json['status'] ?? false,
      message: json['message'] ?? '',
      data: (json['data'] as List?)?.map((e) => Patient.fromJson(e)).toList() ??
          [],
    );
  }

  final bool status;
  final String message;
  final List<Patient> data;
}

class Patient {
  Patient({
    required this.id,
    required this.userId,
    required this.firstName,
    required this.surname,
    required this.email,
    required this.phone,
    required this.dob,
    required this.age,
    required this.gender,
    required this.image,
    required this.address,
    required this.profession,
    required this.primaryContactName,
    required this.relationship,
    required this.status,
    required this.createdAt,
  });

  factory Patient.fromJson(Map<String, dynamic> json) {
    return Patient(
      id: json['id'] ?? 0,
      userId: json['user_id'] ?? 0,
      firstName: json['first_name'] ?? '',
      surname: json['surname'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      dob: json['dob'] ?? '',
      age: json['age'] ?? 0,
      gender: json['gender'] ?? '',
      image: json['image'] ?? '',
      address: json['address'] ?? '',
      profession: json['profession'] ?? '',
      primaryContactName: json['primary_contact_name'] ?? '',
      relationship: json['relationship'] ?? '',
      status: json['status'] ?? 0,
      createdAt: json['created_at'] ?? '',
    );
  }

  final int id;
  final int userId;
  final String firstName;
  final String surname;
  final String email;
  final String phone;
  final String dob;
  final int age;
  final String gender;
  final String image;
  final String address;
  final String profession;
  final String primaryContactName;
  final String relationship;
  final int status;
  final String createdAt;

  String get fullName => '$firstName $surname';
}
