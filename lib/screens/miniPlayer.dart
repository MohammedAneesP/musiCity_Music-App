// ignore_for_file: file_names

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musi_city/application/recently_played/recently_played_bloc.dart';
import 'package:musi_city/functions/box_opening.dart';
import 'package:musi_city/functions/functions.dart';
import 'package:musi_city/main.dart';
import 'package:musi_city/models/home_models.dart';
import 'package:musi_city/models/recently_model.dart';
import 'package:musi_city/nowPlaying/nowplaying_screen.dart';
import 'package:on_audio_query/on_audio_query.dart';

class MiniPlayerBottom extends StatefulWidget {
  const MiniPlayerBottom({super.key});

  @override
  State<MiniPlayerBottom> createState() => _MiniPlayerBottomState();
}

class _MiniPlayerBottomState extends State<MiniPlayerBottom> {
  late List<AllSong> miniRecentSong;

  @override
  void initState() {
    miniRecentSong = allSongList.values.toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final mqheight = MediaQuery.of(context).size.height;
    final mqwidth = MediaQuery.of(context).size.width;
    return player.builderCurrent(
      builder: (context, playing) {
        return Container(
          height: 76,
          width: mqwidth * 4,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            boxShadow: const [
              BoxShadow(
                offset: Offset.zero,
                blurRadius: 30,
                blurStyle: BlurStyle.outer,
              )
            ],
           // color: musiCityBgColor,
            border: Border.all(
             // color: whiteColor,
            ),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => NowPlayingScreeen(
                              currentPlayIndex: playing.index),
                        ),
                      );
                    },
                    child: Row(
                      children: [
                        SizedBox(
                          width: mqwidth * .02,
                        ),
                        SizedBox(
                          height: mqheight * 0.065,
                          width: mqwidth * 0.14,
                          child: QueryArtworkWidget(
                            id: int.parse(playing.audio.audio.metas.id!),
                            type: ArtworkType.AUDIO,
                            artworkFit: BoxFit.cover,
                            artworkBorder: BorderRadius.circular(70),
                            artworkQuality: FilterQuality.high,
                            nullArtworkWidget: CircleAvatar(
                              radius: 28,
                              backgroundImage: AssetImage(
                                  leadingImage),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 70,
                          width: mqwidth * .4,
                          child: ListTile(
                            title: Text(
                              player.getCurrentAudioTitle,
                              style: const TextStyle(
                                //  color: whiteColor,
                                  overflow: TextOverflow.ellipsis),
                            ),
                            subtitle: Text(
                              player.getCurrentAudioArtist,
                              style: const TextStyle(
                                 // color: Colors.white70,
                                  overflow: TextOverflow.ellipsis),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 70,
                    width: mqwidth * .432,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        IconButton(
                          onPressed: playing.index == 0
                              ? () {}
                              : () async {
                                  await player.previous();
                                  RecentlyModel miniPreRecSong;
                                  miniPreRecSong = RecentlyModel(
                                      recentSongName:
                                          miniRecentSong[playing.index - 1]
                                              .songName,
                                      recentArtists:
                                          miniRecentSong[playing.index - 1]
                                              .artists,
                                      recentDuration:
                                          miniRecentSong[playing.index - 1]
                                              .duration,
                                      recentSongurl:
                                          miniRecentSong[playing.index - 1]
                                              .songurl,
                                      recentId:
                                          miniRecentSong[playing.index - 1].id);
                                  updateRecentlyPlayed(
                                      miniPreRecSong, playing.index - 1,context);
                                      BlocProvider.of<RecentlyPlayedBloc>(context).add(RecentShowListEvent());
                                },
                          icon: playing.index == 0
                              ? const Icon(
                                  Icons.skip_previous_rounded,
                                  size: 30,
                                  color: Color.fromARGB(255, 134, 130, 130),
                                )
                              : const Icon(
                                  Icons.skip_previous_rounded,
                                  size: 30,
                                  //color: whiteColor,
                                ),
                        ),
//---------------------------------------------------previous button------------------------------------------//

                        CircleAvatar(
                          backgroundColor: Colors.blue,
                          radius: 27,
                          child: PlayerBuilder.isPlaying(
                            player: player,
                            builder: (context, isPlaying) {
                              return IconButton(
                                onPressed: () {
                                  player.playOrPause();
                                },
                                icon: Icon(
                                  isPlaying == true
                                      ? Icons.pause_rounded
                                      : Icons.play_arrow_rounded,
                                  color: Colors.black,
                                  size: 30,
                                ),
                              );
                            },
                          ),
                        ),

//---------------------------------------------------Play Pause Button-----------------------------------------------//

                        IconButton(
                          onPressed: playing.index ==
                                  playing.playlist.audios.length - 1
                              ? () {}
                              : () {
                                  player.next();
                                  RecentlyModel miniNextRecSong;
                                  miniNextRecSong = RecentlyModel(
                                      recentSongName:
                                          miniRecentSong[playing.index + 1]
                                              .songName,
                                      recentArtists:
                                          miniRecentSong[playing.index + 1]
                                              .artists,
                                      recentDuration:
                                          miniRecentSong[playing.index + 1]
                                              .duration,
                                      recentSongurl:
                                          miniRecentSong[playing.index + 1]
                                              .songurl,
                                      recentId:
                                          miniRecentSong[playing.index + 1].id);
                                  updateRecentlyPlayed(
                                      miniNextRecSong, playing.index + 1,context);
                                      //BlocProvider.of<RecentlyPlayedBloc>(context).add(RecentShowListEvent());
                                  if (playing == false) {
                                    player.pause();
                                  }
                                },
                          icon: playing.index ==
                                  playing.playlist.audios.length - 1
                              ? const Icon(
                                  Icons.skip_next_rounded,
                                  color: Colors.white30,
                                )
                              :  const Icon(
                                  Icons.skip_next_rounded,
                                  //color: whiteColor,
                                ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
