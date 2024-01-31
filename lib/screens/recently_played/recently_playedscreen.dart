// import 'dart:developer';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musi_city/application/recently_played/recently_played_bloc.dart';
import 'package:musi_city/functions/box_opening.dart';
import 'package:musi_city/functions/functions.dart';
import 'package:musi_city/main.dart';
import 'package:musi_city/models/home_models.dart';
import 'package:musi_city/models/recently_model.dart';
import 'package:musi_city/screens/favorites/addfavorite.dart';
import 'package:musi_city/screens/my_playlists/add_fromhome.dart';
import 'package:musi_city/screens/now_playing/nowplaying_screen.dart';
import 'package:musi_city/screens/recently_played/widgets/empty_recently.dart';
import 'package:on_audio_query/on_audio_query.dart';

class RecentlyPlayedScreen extends StatelessWidget {
  RecentlyPlayedScreen({super.key});

  final AssetsAudioPlayer recAudioPlayer = AssetsAudioPlayer.withId('0');

  List<AllSong> fullSongForRecnly = allSongList.values.toList();

  List<Audio> recConvertAudio = [];

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<RecentlyPlayedBloc>(context).add(RecentShowListEvent());

    final mqheight = MediaQuery.of(context).size.height;
    final mqwidth = MediaQuery.of(context).size.width;

    return BlocBuilder<RecentlyPlayedBloc, RecentlyPlayedState>(
      builder: (context, state) {
        if (state.recentMusic.isEmpty) {
          return EmptyRecentlyPlayed(mqheight: mqheight, mqwidth: mqwidth);
        } else {
          recConvertAudio.clear();
          for (var element in state.recentMusic) {
            recConvertAudio.add(
              Audio.file(
                element.recentSongurl,
                metas: Metas(
                  id: element.recentId.toString(),
                  title: element.recentSongName,
                  artist: element.recentArtists,
                ),
              ),
            );
          }
          List<RecentlyModel> allRecentSong =
              state.recentMusic.reversed.toList();
          return Scaffold(
            body: SafeArea(
              child: Column(
                children: [
                  SizedBox(
                    height: mqheight * 0.1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          height: mqheight * 0.29,
                          width: mqwidth * 0.83,
                          decoration: const BoxDecoration(
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
                                    BlocProvider(
                                      create: (context) => RecentlyPlayedBloc(),
                                      child: TextButton(
                                        onPressed: () async {
                                          showDialog(
                                            context: context,
                                            builder: (context) => const Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            ),
                                          );
                                          await recentlyPlayedBox.clear();
                                          if (context.mounted) {
                                            BlocProvider.of<RecentlyPlayedBloc>(
                                                    context)
                                                .add(RecentShowListEvent());
                                            Navigator.pop(context);
                                            Navigator.pop(context);
                                          }
                                        },
                                        child: const Text("Yes"),
                                      ),
                                    )
                                  ],
                                );
                              },
                            );
                          },
                          icon: const Icon(
                            Icons.delete,
                          ),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: SizedBox(
                      child: ListView.separated(
                          itemBuilder: (context, index) {
                            RecentlyModel recFullSong = allRecentSong[index];

                            return ListTile(
                              onTap: () {
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
                                  backgroundImage: AssetImage(leadingImage),
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
                                                              allRecentSong[
                                                                      index]
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
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return const Divider();
                          },
                          itemCount: allRecentSong.length),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
