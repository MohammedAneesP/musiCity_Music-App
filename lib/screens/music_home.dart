import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musi_city/application/music_home_screen/music_home_screen_bloc.dart';
import 'package:musi_city/application/recently_played/recently_played_bloc.dart';
import 'package:musi_city/screens/favorites/addfavorite.dart';
import 'package:musi_city/functions/box_opening.dart';
import 'package:musi_city/functions/functions.dart';
import 'package:musi_city/models/home_models.dart';
import 'package:musi_city/models/mostly_model.dart';
import 'package:musi_city/models/recently_model.dart';
import 'package:musi_city/screens/more_options/more_option.dart';
import 'package:musi_city/screens/my_playlists/add_fromhome.dart';
import 'package:musi_city/screens/now_playing/nowplaying_screen.dart';
import 'package:musi_city/screens/search_screen/searchscreen.dart';
import 'package:on_audio_query/on_audio_query.dart';

class MusiHomeScreen extends StatelessWidget {
  MusiHomeScreen({super.key});
  List<Audio> homeMusicConvrt = [];

  final AssetsAudioPlayer _audioPlayers = AssetsAudioPlayer.withId('0');


  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<MusicHomeScreenBloc>(context).add(HomeScreenSong());
    });
    final mqheight = MediaQuery.of(context).size.height;
    final mqwidth = MediaQuery.of(context).size.width;
    return Scaffold(
      // backgroundColor: musiCityBgColor,
      appBar: AppBar(
        title: const Text(
          "MusiCity",
          style: headingStyle,
        ),
        actions: [
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
                  builder: (context) => MoreOPtionScreen(),
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
      body: Column(
        children: [
          Expanded(
            child: SizedBox(
              child: BlocBuilder<MusicHomeScreenBloc, MusicHomeScreenState>(
                builder: (context, state) {
                  for (var element in state.homeSongs) {
                    homeMusicConvrt.add(
                      Audio.file(
                        element.songurl,
                        metas: Metas(
                          id: element.id.toString(),
                          title: element.songName,
                          artist: element.artists,
                        ),
                      ),
                    );
                  }
                  List<MostlyModel> homeMostPlayed =
                      mostlyPlayedBox.values.toList();
                  if (state.homeSongs.isEmpty) {
                    return const Center(child: Text("No Song Found"));
                  }

                  return ListView.separated(
                    //shrinkWrap: true,
                    itemBuilder: (context, index) {
                      AllSong homeSongs = state.homeSongs[index];
                      RecentlyModel recentSongs;
                      MostlyModel homeMostlyPlayObj = homeMostPlayed[index];

                      return ListTile(
                        onTap: () {
                          GestureDetector();
                          _audioPlayers.open(
                              Playlist(
                                audios: homeMusicConvrt,
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
                          updateRecentlyPlayed(recentSongs, index, context);
                          BlocProvider.of<RecentlyPlayedBloc>(context)
                              .add(RecentShowListEvent());
                          updateMostlyPlayed(index, homeMostlyPlayObj);
                          // setState(() {});
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.center,
                                    children: [
                                      InkWell(
                                        onTap: () {},
                                        child: SizedBox(
                                          height: mqheight * .070,
                                          width: mqwidth * 1,
                                          child: Center(
                                            child:
                                                AddToFavorite(index: index),
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
                    itemCount: state.homeSongs.length,
                  );
                },
              ),
            ),
          ),
          SizedBox(height: mqheight * 0.0045,)
        ],
      ),
    );
  }
}
