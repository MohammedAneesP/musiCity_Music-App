import 'package:hive/hive.dart';
part 'favorite_model.g.dart';


@HiveType(typeId: 2)
class FavoriteModel {

  @HiveField(0)
  String favSongName;

   @HiveField(1)
  String favSongArtist;

   @HiveField(2)
  int favSongDuration;

   @HiveField(3)
  String favSongUrl;

   @HiveField(4)
  int favSongId;

  FavoriteModel({
   required this.favSongName,
   required this.favSongArtist,
   required this.favSongDuration,
   required this.favSongUrl,
   required this.favSongId
  });
}