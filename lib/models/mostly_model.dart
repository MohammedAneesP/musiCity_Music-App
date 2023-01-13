import 'package:hive/hive.dart';
part 'mostly_model.g.dart';

@HiveType(typeId: 4)
class MostlyModel {
  @HiveField(0)
  String mostlySongName;

  @HiveField(1)
  String mostlyArtistName;

  @HiveField(2)
  int mostlyDuration;

  @HiveField(3)
  String mostlySongUrl;

  @HiveField(4)
  int songCount;

  @HiveField(5)
  int mostlySongId;

  MostlyModel(
      {required this.mostlySongName,
      required this.mostlyArtistName,
      required this.mostlyDuration,
      required this.mostlySongUrl,
      required this.songCount,
      required this.mostlySongId});
}
