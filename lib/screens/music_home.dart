import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:musi_city/favorites/addfavorite.dart';
import 'package:musi_city/functions/box_opening.dart';
import 'package:musi_city/functions/functions.dart';
import 'package:musi_city/main.dart';
import 'package:musi_city/models/home_models.dart';
import 'package:musi_city/models/mostly_model.dart';
import 'package:musi_city/models/recently_model.dart';
import 'package:musi_city/moreOptions/more_option.dart';
import 'package:musi_city/my_playlists/add_fromhome.dart';
import 'package:musi_city/nowPlaying/nowplaying_screen.dart';
import 'package:musi_city/searchScreen/searchscreen.dart';
import 'package:on_audio_query/on_audio_query.dart';

class MusiHomeScreen extends StatefulWidget {
  const MusiHomeScreen({super.key});

  @override
  State<MusiHomeScreen> createState() => _MusiHomeScreenState();
}

class _MusiHomeScreenState extends State<MusiHomeScreen> {
  List<Audio> convertAudios = [];

  final AssetsAudioPlayer _audioPlayers = AssetsAudioPlayer.withId('0');

  @override
  void initState() {
    List<AllSong> dbsongs = allSongList.values.toList();
    for (var items in dbsongs) {
      convertAudios.add(
        Audio.file(
          items.songurl,
          metas: Metas(
            title: items.songName,
            artist: items.artists,
            id: items.id.toString(),
          ),
        ),
      );
    }

    // ignore: todo
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final mqheight = MediaQuery.of(context).size.height;
    final mqwidth = MediaQuery.of(context).size.width;
    return Scaffold(
      // backgroundColor: musiCityBgColor,
      body: Column(
        children: [
          Container(
            //color: musiCityBgColor,
            height: mqheight * .04,
          ),
          SizedBox(
            // decoration: conatainerDecoration,
            height: mqheight * 0.09,
            child: Padding(
              padding: EdgeInsets.fromLTRB(mqwidth * 0.04, 0, 0, 0),
              child: Row(
                children: [
                  Container(
                    height: mqheight * 0.22,
                    width: mqwidth * 0.54,
                    decoration: const BoxDecoration(
                        // color: Colors.amber,
                        image: DecorationImage(
                            image: AssetImage(
                              'assets/Picsart_23-01-16_20-20-47-555.png',
                            ),
                            fit: BoxFit.cover)),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(
                        mqwidth * .15, mqheight * 0.02, 0, 0),
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const SearchScreen(),
                              ),
                            );
                          },
                          icon: const Icon(
                            Icons.search_sharp,
                            // color: Colors.white,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const MoreOPtionScreen(),
                              ),
                            );
                          },
                          icon: const Icon(
                            Icons.density_medium_rounded,
                            // color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: SizedBox(
              child: ValueListenableBuilder<Box<AllSong>>(
                valueListenable: allSongList.listenable(),
                builder: (BuildContext, Box<AllSong> fullSongList, child) {
                  List<AllSong> allDbSong = fullSongList.values.toList();
                  List<MostlyModel> homeMostPlayed =
                      mostlyPlayedBox.values.toList();

                  if (allDbSong.isEmpty) {
                    return const Text("NO data");
                  }

                  return ListView.separated(
                    //shrinkWrap: true,
                    itemBuilder: (context, index) {
                      AllSong homeSongs = allDbSong[index];
                      RecentlyModel recentSongs;
                      MostlyModel homeMostlyPlayObj = homeMostPlayed[index];

                      return ListTile(
                        onTap: () {
                          GestureDetector();
                          _audioPlayers.open(
                              Playlist(
                                audios: convertAudios,
                                startIndex: index,
                              ),
                              showNotification: true,
                              headPhoneStrategy:
                                  HeadPhoneStrategy.pauseOnUnplug,
                              loopMode: LoopMode.playlist);
                          recentSongs = RecentlyModel(
                            recentSongName: homeSongs.songName,
                            recentArtists: homeSongs.artists,
                            recentDuration: homeSongs.duration,
                            recentSongurl: homeSongs.songurl,
                            recentId: homeSongs.id,
                          );
                          updateRecentlyPlayed(recentSongs, index);
                          updateMostlyPlayed(index, homeMostlyPlayObj);
                          setState(() {});
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => NowPlayingScreeen(
                                currentPlayIndex: index,
                              ),
                            ),
                          );
                        },
                        leading: QueryArtworkWidget(
                          id: homeSongs.id,
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
                          homeSongs.songName,
                          overflow: TextOverflow.ellipsis,
                          style: songNameStyle,
                        ),
                        subtitle: Text(
                          homeSongs.artists,
                          overflow: TextOverflow.ellipsis,
                          style: songNameStyle,
                        ),
                        trailing: IconButton(
                          onPressed: () {
                            showModalBottomSheet(
                              context: context,
                              builder: ((context) {
                                return SizedBox(
                                  // color:
                                  //  const Color.fromARGB(255, 45, 13, 13),
                                  height: mqheight * .15,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      InkWell(
                                        onTap: () {},
                                        child: SizedBox(
                                          height: mqheight * .070,
                                          width: mqwidth * 1,
                                          child: Center(
                                            child: AddToFavorite(index: index),
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
                                                songIndex: index),
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
                            // color: whiteColor,
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const Divider();
                    },
                    itemCount: allDbSong.length,
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
