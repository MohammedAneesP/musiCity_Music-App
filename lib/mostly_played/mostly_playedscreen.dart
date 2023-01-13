import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:musi_city/functions/box_opening.dart';
import 'package:musi_city/functions/functions.dart';
import 'package:musi_city/main.dart';
import 'package:musi_city/models/home_models.dart';
import 'package:musi_city/mostly_played/add_to_fav_icon.dart';
import 'package:musi_city/nowPlaying/nowplaying_screen.dart';
import 'package:on_audio_query/on_audio_query.dart';
import '../models/mostly_model.dart';

class MostlyPlayedScreen extends StatefulWidget {
  const MostlyPlayedScreen({super.key});

  @override
  State<MostlyPlayedScreen> createState() => _MostlyPlayedScreenState();
}

List<MostlyModel> mostlyScreenSongs = [];

class _MostlyPlayedScreenState extends State<MostlyPlayedScreen> {
  List<Audio> mostlyConvrtAudio = [];
  final AssetsAudioPlayer mosplyAudioPlyr = AssetsAudioPlayer.withId('0');
  late List<AllSong> allsongMostly;
  late List<AllSong> fullSongForMostly;

  @override
  void initState() {
    fullSongForMostly = allSongList.values.toList();
    List<MostlyModel> msPldSongList = mostlyPlayedBox.values.toList();
    int i = 0;
    for (var oneSongCount in msPldSongList) {
      if (oneSongCount.songCount >= 3) {
        mostlyScreenSongs.remove(oneSongCount);
        mostlyScreenSongs.insert(i, oneSongCount);
        i++;
      }
    }

    for (var items in mostlyScreenSongs) {
      mostlyConvrtAudio.add(
        Audio.file(
          items.mostlySongUrl,
          metas: Metas(
            title: items.mostlySongName,
            artist: items.mostlyArtistName,
            id: items.mostlySongId.toString(),
          ),
        ),
      );
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final mqheight = MediaQuery.of(context).size.height;
    final mqwidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: musiCityBgColor,
      body: Column(
        children: [
          SizedBox(
            height: mqheight * .05,
          ),
          SizedBox(
            height: mqheight * 0.05,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Mostly Played",
                  style: headingStyle,
                ),
              ],
            ),
          ),
          Expanded(
            child: SizedBox(
              child: ValueListenableBuilder(
                valueListenable: mostlyPlayedBox.listenable(),
                builder: (BuildContext, Box<MostlyModel> mostlyScreenList, _) {
                  List<MostlyModel> mostlySonglist =
                      mostlyScreenList.values.toList();
                  if (mostlySonglist.isEmpty) {
                    return Center(
                      child: Text('''Nothing Played that much''',
                          style: defaultTextStyle),
                    );
                  } else {
                    return ListView.separated(
                        itemBuilder: (context, index) {
                          return ListTile(
                            onTap: () {
                              mosplyAudioPlyr.open(
                                Playlist(
                                    audios: mostlyConvrtAudio,
                                    startIndex: index),
                                headPhoneStrategy:
                                    HeadPhoneStrategy.pauseOnUnplug,
                                loopMode: LoopMode.playlist,
                                showNotification: true,
                              );
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) {
                                  return NowPlayingScreeen(
                                      currentPlayIndex: index);
                                },
                              ));
                            },
                            leading: QueryArtworkWidget(
                              id: mostlyScreenSongs[index].mostlySongId,
                              type: ArtworkType.AUDIO,
                              artworkFit: BoxFit.cover,
                              artworkQuality: FilterQuality.high,
                              quality: 100,
                              artworkBorder: BorderRadius.circular(30),
                              nullArtworkWidget: const CircleAvatar(
                                radius: 25,
                                backgroundImage: AssetImage(
                                    'assets/pexels-sebastian-ervi-1763075.jpg'),
                              ),
                            ),
                            title: Text(
                              mostlyScreenSongs[index].mostlySongName,
                              style: songNameStyle,
                              overflow: TextOverflow.ellipsis,
                            ),
                            subtitle: Text(
                              mostlyScreenSongs[index].mostlyArtistName,
                              style: songNameStyle,
                              overflow: TextOverflow.ellipsis,
                            ),
                            trailing: AddToFAvIcon(
                              index: fullSongForMostly.indexWhere(
                                (element) =>
                                    element.songName ==
                                    mostlyScreenSongs[index].mostlySongName,
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (context, index) => const Divider(),
                        itemCount: mostlyScreenSongs.length);
                  }
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
