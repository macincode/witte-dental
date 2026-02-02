// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'business_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BusinessAdapter extends TypeAdapter<Business> {
  @override
  final int typeId = 2;

  @override
  Business read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Business(
      id: fields[0] as int,
      name: fields[1] as String,
      businessType: fields[2] as String,
      role: fields[3] as String,
      subscription: fields[4] as Subscription?,
      hospitals: (fields[5] as List?)?.cast<Hospital>(),
    );
  }

  @override
  void write(BinaryWriter writer, Business obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.businessType)
      ..writeByte(3)
      ..write(obj.role)
      ..writeByte(4)
      ..write(obj.subscription)
      ..writeByte(5)
      ..write(obj.hospitals);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BusinessAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
