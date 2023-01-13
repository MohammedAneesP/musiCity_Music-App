import 'package:hive/hive.dart';
import 'package:musi_city/models/home_models.dart';
part 'playlist_model.g.dart';

@HiveType(typeId: 3)
class PlaylistModel {

  @HiveField(0)
  String playlistName ;

  @HiveField(1)
  List <AllSong> playlistSongs;

  PlaylistModel({
    required this.playlistName,
    required this.playlistSongs
  }); 
}