// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorite_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FavoriteModelAdapter extends TypeAdapter<FavoriteModel> {
  @override
  final int typeId = 2;

  @override
  FavoriteModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FavoriteModel(
      favSongName: fields[0] as String,
      favSongArtist: fields[1] as String,
      favSongDuration: fields[2] as int,
      favSongUrl: fields[3] as String,
      favSongId: fields[4] as int,
    );
  }

  @override
  void write(BinaryWriter writer, FavoriteModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.favSongName)
      ..writeByte(1)
      ..write(obj.favSongArtist)
      ..writeByte(2)
      ..write(obj.favSongDuration)
      ..writeByte(3)
      ..write(obj.favSongUrl)
      ..writeByte(4)
      ..write(obj.favSongId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FavoriteModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
