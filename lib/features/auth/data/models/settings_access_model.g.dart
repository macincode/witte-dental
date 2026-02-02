// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_access_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SettingsAccessAdapter extends TypeAdapter<SettingsAccess> {
  @override
  final int typeId = 5;

  @override
  SettingsAccess read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SettingsAccess(
      saasManagement: fields[0] as bool,
      businessManagement: fields[1] as bool,
      hospitalManagement: fields[2] as bool,
      subscriptionManagement: fields[3] as bool,
      teamManagement: fields[4] as bool,
      membershipPlans: fields[5] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, SettingsAccess obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.saasManagement)
      ..writeByte(1)
      ..write(obj.businessManagement)
      ..writeByte(2)
      ..write(obj.hospitalManagement)
      ..writeByte(3)
      ..write(obj.subscriptionManagement)
      ..writeByte(4)
      ..write(obj.teamManagement)
      ..writeByte(5)
      ..write(obj.membershipPlans);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SettingsAccessAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
