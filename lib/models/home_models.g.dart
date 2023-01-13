// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_models.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AllSongAdapter extends TypeAdapter<AllSong> {
  @override
  final int typeId = 0;

  @override
  AllSong read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AllSong(
      songName: fields[0] as String,
      artists: fields[1] as String,
      duration: fields[2] as int,
      songurl: fields[3] as String,
      id: fields[4] as int,
    );
  }

  @override
  void write(BinaryWriter writer, AllSong obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.songName)
      ..writeByte(1)
      ..write(obj.artists)
      ..writeByte(2)
      ..write(obj.duration)
      ..writeByte(3)
      ..write(obj.songurl)
      ..writeByte(4)
      ..write(obj.id);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AllSongAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
