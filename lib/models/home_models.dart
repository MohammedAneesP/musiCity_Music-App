import 'package:hive/hive.dart';
part 'home_models.g.dart';

@HiveType(typeId:0)
class AllSong {

  @HiveField(0)
  String songName;

  @HiveField(1)
  String artists;

  @HiveField(2)
  int duration;

  @HiveField(3)
  String songurl;

  @HiveField(4)
  int id;

  AllSong({
    required this.songName,
    required this.artists,
    required this.duration,
    required this.songurl,
    required this.id
  });

}