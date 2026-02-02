// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hospital_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HospitalAdapter extends TypeAdapter<Hospital> {
  @override
  final int typeId = 3;

  @override
  Hospital read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Hospital(
      id: fields[0] as int,
      name: fields[1] as String,
      code: fields[2] as String,
      isMain: fields[3] as bool,
      hasAccess: fields[4] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, Hospital obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.code)
      ..writeByte(3)
      ..write(obj.isMain)
      ..writeByte(4)
      ..write(obj.hasAccess);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HospitalAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
