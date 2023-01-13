import 'package:hive/hive.dart';
part 'recently_model.g.dart';


@HiveType(typeId: 1)
class RecentlyModel {

  @HiveField(0)
  String recentSongName;

  @HiveField(1)
  String recentArtists;

  @HiveField(2)
  int recentDuration;

  @HiveField(3)
  String recentSongurl;

  @HiveField(4)
  int recentId;

  RecentlyModel({
    required this.recentSongName,
    required this.recentArtists,
    required this.recentDuration,
    required this.recentSongurl,
    required this.recentId,
  });
}
