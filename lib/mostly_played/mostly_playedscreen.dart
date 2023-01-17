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

    // log(msPldSongList.toString());

    for (var oneSong in msPldSongList) {
      if (oneSong.songCount >= 3) {
        mostlyScreenSongs.remove(oneSong);
        mostlyScreenSongs.add(oneSong);
      }
      // log(oneSong.toString());
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
      //  backgroundColor: musiCityBgColor,
      body: Column(
        children: [
          SizedBox(
            height: mqheight * .05,
          ),
          SizedBox(
            height: mqheight * 0.1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  height: mqheight * 0.28,
                  width: mqwidth * 0.815,
                  decoration: const BoxDecoration(
                  //  color: Colors.amber,
                    image: DecorationImage(
                        image: AssetImage('assets/mostly.png'),
                        fit: BoxFit.cover),
                  ),
                ),
                SizedBox(
                  width: mqwidth * 0.06,
                ),
                IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title:
                              const Text("Do you want to clear all songs..?"),
                          content: const Text("Are you Sure..."),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text("Cancel"),
                            ),
                            TextButton(
                                onPressed: () {
                                  mostlyScreenSongs.clear();
                                  setState(() {});
                                  Navigator.pop(context);
                                },
                                child: const Text("Yes"))
                          ],
                        );
                      },
                    );
                  },
                  icon: const Icon(
                    Icons.delete,
                    // color: whiteColor,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: SizedBox(
              child: ValueListenableBuilder(
                valueListenable: mostlyPlayedBox.listenable(),
                // ignore: avoid_types_as_parameter_names, non_constant_identifier_names
                builder: (BuildContext, Box<MostlyModel> mostlyScreenList, _) {
                  if (mostlyScreenSongs.isEmpty) {
                    return Center(
                      child: Text(
                        'Nothing Played yet',
                        style: defaultTextStyle,
                      ),
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
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) {
                                    return NowPlayingScreeen(
                                      currentPlayIndex:
                                          fullSongForMostly.indexWhere(
                                        (element) =>
                                            element.songName ==
                                            mostlyScreenSongs[index]
                                                .mostlySongName,
                                      ),
                                    );
                                  },
                                ),
                              );
                            },
                            leading: QueryArtworkWidget(
                              id: mostlyScreenSongs[index].mostlySongId,
                              type: ArtworkType.AUDIO,
                              artworkFit: BoxFit.cover,
                              artworkQuality: FilterQuality.high,
                              quality: 100,
                              artworkBorder: BorderRadius.circular(30),
                              nullArtworkWidget: CircleAvatar(
                                radius: 25,
                                backgroundImage: AssetImage(leadingImage),
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
