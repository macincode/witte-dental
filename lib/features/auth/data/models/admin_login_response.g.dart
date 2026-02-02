// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_login_response.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AdminLoginResponseAdapter extends TypeAdapter<AdminLoginResponse> {
  @override
  final int typeId = 0;

  @override
  AdminLoginResponse read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AdminLoginResponse(
      success: fields[0] as bool,
      message: fields[1] as String,
      userType: fields[2] as String,
      data: fields[3] as User?,
      token: fields[4] as String?,
      businesses: (fields[5] as List?)?.cast<Business>(),
      currentBusiness: fields[6] as Business?,
      currentHospital: fields[7] as Hospital?,
      settingsAccess: fields[8] as SettingsAccess?,
    );
  }

  @override
  void write(BinaryWriter writer, AdminLoginResponse obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.success)
      ..writeByte(1)
      ..write(obj.message)
      ..writeByte(2)
      ..write(obj.userType)
      ..writeByte(3)
      ..write(obj.data)
      ..writeByte(4)
      ..write(obj.token)
      ..writeByte(5)
      ..write(obj.businesses)
      ..writeByte(6)
      ..write(obj.currentBusiness)
      ..writeByte(7)
      ..write(obj.currentHospital)
      ..writeByte(8)
      ..write(obj.settingsAccess);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AdminLoginResponseAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
