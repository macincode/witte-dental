import 'package:hive/hive.dart';

part 'hospital_model.g.dart';

@HiveType(typeId: 3)
class Hospital extends HiveObject {
  Hospital({
    required this.id,
    required this.name,
    required this.code,
    required this.isMain,
    required this.hasAccess,
  });

  factory Hospital.fromJson(Map<String, dynamic> json) {
    return Hospital(
      id: json['id'],
      name: json['name'],
      code: json['code'],
      isMain: json['is_main'],
      hasAccess: json['has_access'],
    );
  }
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String code;

  @HiveField(3)
  final bool isMain;

  @HiveField(4)
  final bool hasAccess;
}
