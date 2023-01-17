import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:musi_city/functions/box_opening.dart';
import 'package:musi_city/functions/functions.dart';
import 'package:musi_city/main.dart';
import 'package:musi_city/models/home_models.dart';
import 'package:musi_city/models/recently_model.dart';
import 'package:musi_city/nowPlaying/nowplaying_screen.dart';
import 'package:on_audio_query/on_audio_query.dart';
import '../favorites/addfavorite.dart';
import '../my_playlists/add_fromhome.dart';

class RecentlyPlayedScreen extends StatefulWidget {
  const RecentlyPlayedScreen({super.key});

  @override
  State<RecentlyPlayedScreen> createState() => _RecentlyPlayedScreenState();
}

class _RecentlyPlayedScreenState extends State<RecentlyPlayedScreen> {
  List<Audio> recConvertAudio = [];
  final AssetsAudioPlayer recAudioPlayer = AssetsAudioPlayer.withId('0');
  late List<AllSong> fullSongForRecnly;

  @override
  void initState() {
    fullSongForRecnly = allSongList.values.toList();
    List<RecentlyModel> recentPlaying =
        recentlyPlayedBox.values.toList().reversed.toList();
    for (var recItem in recentPlaying) {
      recConvertAudio.add(
        Audio.file(
          recItem.recentSongurl,
          metas: Metas(
            title: recItem.recentSongName,
            artist: recItem.recentArtists,
            id: recItem.recentId.toString(),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final mqheight = MediaQuery.of(context).size.height;
    final mqwidth = MediaQuery.of(context).size.width;

    return Scaffold(
     // backgroundColor: musiCityBgColor,
      body: Column(
        children: [
          SizedBox(
            height: mqheight * .045,
          ),
          SizedBox(
            height: mqheight * 0.1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                   height: mqheight * 0.29,
                width: mqwidth * 0.83,
                decoration: const BoxDecoration(
                  //color: Colors.amber,
                  image: DecorationImage(
                      image: AssetImage('assets/recently.png'),
                      fit: BoxFit.cover),
                ),
                ),
                IconButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text(
                                "Do you want to delete whole recent songs..?"),
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
                                    recentlyPlayedBox.clear();
                                    setState(() {});
                                    Navigator.pop(context);
                                  },
                                  child: const Text("Yes"))
                            ],
                          );
                        },
                      );
                    },
                    icon:const Icon(
                      Icons.delete,
                     // color: whiteColor,
                    ),)
              ],
            ),
          ),
          Expanded(
            child: SizedBox(
              child: ValueListenableBuilder(
                valueListenable: recentlyPlayedBox.listenable(),
                builder:
                    (BuildContext, Box<RecentlyModel> recentPlaySong, child) {
                  List<RecentlyModel> allRecentSong =
                      recentPlaySong.values.toList().reversed.toList();
                  if (allRecentSong.isEmpty) {
                    return Center(
                      child: Text("Nothing yet Played.....",
                          style: defaultTextStyle),
                    );
                  }

                  return ListView.separated(
                      itemBuilder: (context, index) {
                        RecentlyModel recFullSong = allRecentSong[index];

                        return ListTile(
                          onTap: () {
                            GestureDetector();

                            recAudioPlayer.open(
                                Playlist(
                                    audios: recConvertAudio,
                                    startIndex: index),
                                loopMode: LoopMode.playlist,
                                showNotification: true,
                                headPhoneStrategy:
                                    HeadPhoneStrategy.pauseOnUnplug);

                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => NowPlayingScreeen(
                                  currentPlayIndex:
                                      fullSongForRecnly.indexWhere(
                                    (element) =>
                                        element.songName ==
                                        recFullSong.recentSongName,
                                  ),
                                ),
                              ),
                            );
                          },
                          leading: QueryArtworkWidget(
                            id: recFullSong.recentId,
                            type: ArtworkType.AUDIO,
                            artworkFit: BoxFit.cover,
                            artworkQuality: FilterQuality.high,
                            quality: 100,
                            artworkBorder: BorderRadius.circular(30),
                            nullArtworkWidget: CircleAvatar(
                              radius: 25,
                              backgroundImage: AssetImage(
                                  leadingImage),
                            ),
                          ),
                          title: Text(
                            recFullSong.recentSongName,
                            style: songNameStyle,
                            overflow: TextOverflow.ellipsis,
                          ),
                          subtitle: Text(
                            recFullSong.recentArtists,
                            style: songNameStyle,
                            overflow: TextOverflow.ellipsis,
                          ),
                          trailing: IconButton(
                            onPressed: () {
                              showModalBottomSheet(
                                context: context,
                                builder: ((context) {
                                  return SizedBox(
                                  //  color:
                                    //    const Color.fromARGB(255, 45, 13, 13),
                                    height: mqheight * .15,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        InkWell(
                                          onTap: () {},
                                          child: SizedBox(
                                            height: mqheight * .070,
                                            width: mqwidth * 1,
                                            child: Center(
                                              child: AddToFavorite(
                                                index: fullSongForRecnly
                                                    .indexWhere(
                                                  (element) =>
                                                      element.id ==
                                                      allRecentSong[index]
                                                          .recentId,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Divider(
                                          height: mqheight * .01,
                                         // color: whiteColor,
                                        ),
                                        InkWell(
                                          onTap: () {},
                                          child: SizedBox(
                                            height: mqheight * .070,
                                            width: mqwidth * 1,
                                            child: Center(
                                              child: AddFromHomePlaylist(
                                                  songIndex: fullSongForRecnly
                                                      .indexWhere((element) =>
                                                          element.id ==
                                                          allRecentSong[index]
                                                              .recentId)),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }),
                              );
                            },
                            icon: const Icon(
                              Icons.more_vert_sharp,
                              //color: whiteColor,
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const Divider();
                      },
                      itemCount: allRecentSong.length);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// List listOfRecentlyTitles = [
//   "Track 1",
//   "Track 2",
//   "Track 4",
//   "Track 5",
//   "Track 7",
//   "Track 8",
//   "Track 9",
//   "Track 10",
//   "Track 11",
//   "Track 13",
// ];

// List listOfRecentlySubTitles = [
//   "Singer1",
//   "Singer2",
//   "Singer4",
//   "Singer5",
//   "Singer7",
//   "Singer8",
//   "Singer9",
//   "Singer10",
//   "Singer11",
//   "Singer13",
// ];
