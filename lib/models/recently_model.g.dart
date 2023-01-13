// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recently_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RecentlyModelAdapter extends TypeAdapter<RecentlyModel> {
  @override
  final int typeId = 1;

  @override
  RecentlyModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RecentlyModel(
      recentSongName: fields[0] as String,
      recentArtists: fields[1] as String,
      recentDuration: fields[2] as int,
      recentSongurl: fields[3] as String,
      recentId: fields[4] as int,
    );
  }

  @override
  void write(BinaryWriter writer, RecentlyModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.recentSongName)
      ..writeByte(1)
      ..write(obj.recentArtists)
      ..writeByte(2)
      ..write(obj.recentDuration)
      ..writeByte(3)
      ..write(obj.recentSongurl)
      ..writeByte(4)
      ..write(obj.recentId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RecentlyModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
