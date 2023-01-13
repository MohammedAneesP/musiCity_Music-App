// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mostly_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MostlyModelAdapter extends TypeAdapter<MostlyModel> {
  @override
  final int typeId = 4;

  @override
  MostlyModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MostlyModel(
      mostlySongName: fields[0] as String,
      mostlyArtistName: fields[1] as String,
      mostlyDuration: fields[2] as int,
      mostlySongUrl: fields[3] as String,
      songCount: fields[4] as int,
      mostlySongId: fields[5] as int,
    );
  }

  @override
  void write(BinaryWriter writer, MostlyModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.mostlySongName)
      ..writeByte(1)
      ..write(obj.mostlyArtistName)
      ..writeByte(2)
      ..write(obj.mostlyDuration)
      ..writeByte(3)
      ..write(obj.mostlySongUrl)
      ..writeByte(4)
      ..write(obj.songCount)
      ..writeByte(5)
      ..write(obj.mostlySongId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MostlyModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
