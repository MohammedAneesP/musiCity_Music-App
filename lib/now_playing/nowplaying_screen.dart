
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marquee/marquee.dart';
import 'package:musi_city/application/fav_now_play_button/fav_now_play_button_bloc.dart';
import 'package:musi_city/application/recently_played/recently_played_bloc.dart';
import 'package:musi_city/favorites/fav_now_play.dart';
import 'package:musi_city/functions/box_opening.dart';
import 'package:musi_city/main.dart';
import 'package:musi_city/models/home_models.dart';
import 'package:musi_city/models/recently_model.dart';
import 'package:musi_city/my_playlists/addfromnowplay.dart';
import 'package:on_audio_query/on_audio_query.dart';
import '../functions/functions.dart';

final player = AssetsAudioPlayer.withId('0');

class NowPlayingScreeen extends StatelessWidget {
  NowPlayingScreeen({super.key, required this.currentPlayIndex});

  int currentPlayIndex;

  final List<AllSong> nowRecentSong = allSongList.values.toList();

  bool isRepeat = false;

//   NowPlayingScreeen({super.key, required this.currentPlayIndex});

//   @override
//   State<NowPlayingScreeen> createState() => _NowPlayingScreeenState();
// }

// class _NowPlayingScreeenState extends State<NowPlayingScreeen> {

//   //int forLessTen = 10;

//   @override
//   void initState() {

//     super.initState();
//   }

  @override
  Widget build(BuildContext context) {
    final mqheight = MediaQuery.of(context).size.height;
    final mqwidth = MediaQuery.of(context).size.width;
    // log(currentPlayIndex.toString());
    return player.builderCurrent(
      builder: (context, playing) {
        return Scaffold(
          //backgroundColor: musiCityBgColor,
          body: Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, mqheight * .06, 0, 0),
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.arrow_back_rounded,
                        size: 25,
                        // color: whiteColor,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(
                        mqwidth * .12, mqheight * .06, 0, 0),
                    child: Text(
                      "Now Playing",
                      style: headingStyle,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, mqheight * .07, 0, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: mqheight * 0.52,
                      width: mqwidth * 0.8,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              player.builderCurrent(
                                builder: (context, playing) {
                                  BlocProvider.of<FavNowPlayButtonBloc>(context)
                                      .add(NowFavInitial());
                                  return FavNowPlayButton(
                                      index: currentPlayIndex);
                                },
                              ),
                              AddFromNowPlay(
                                songIndex: nowRecentSong.indexWhere(
                                  (element) =>
                                      element.songName ==
                                      playing.audio.audio.metas.title,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          SizedBox(
                            height: mqheight * .35,
                            width: mqwidth * .7,
                            child: QueryArtworkWidget(
                              artworkFit: BoxFit.cover,
                              id: int.parse(playing.audio.audio.metas.id!),
                              artworkQuality: FilterQuality.high,
                              artworkBorder: BorderRadius.circular(8),
                              type: ArtworkType.AUDIO,
                              nullArtworkWidget: Container(
                                height: mqheight * 0.35,
                                width: mqwidth * 0.7,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(nowPlayImage),
                                    fit: BoxFit.cover,
                                  ),
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(6),
                                  ),
                                ),
                              ),
                            ),
                          ),

//--------------------------------------------------nowPLayImage---------------------------------------------------//

                          const SizedBox(
                            height: 6.5,
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                onPressed: () async {
                                  await player.seekBy(
                                    const Duration(seconds: -10),
                                  );
                                },
                                icon: const Icon(
                                  Icons.replay_10_rounded,
                                  size: 30,
                                  //color: whiteColor,
                                ),
                              ),

//--------------------------------------------------10 sec back-------------------------------------------//

                              SizedBox(
                                height: mqheight * 0.035,
                                width: mqwidth * 0.55,
                                child: Marquee(
                                  text: player.getCurrentAudioTitle,
                                  blankSpace: 150,
                                  style: songNameStyle,
                                  velocity: 30,
                                ),
                              ),

                              IconButton(
                                onPressed: () async {
                                  await player
                                      .seekBy(const Duration(seconds: 10));
                                },
                                icon: const Icon(
                                  Icons.forward_10_rounded,
                                  size: 30,
                                  // color: whiteColor,
                                ),
                              ),

//--------------------------------------------------------10 sec skip--------------------------------------//
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: mqheight * 0.018,
                                width: mqwidth * 0.55,
                                child: Center(
                                  child: Text(
                                    player.getCurrentAudioArtist,
                                    style: const TextStyle(
                                      // color: Colors.white70,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: mqheight * 0.04,
              ),
              PlayerBuilder.realtimePlayingInfos(
                player: player,
                builder: (BuildContext, RealtimePlayingInfos) {
                  final songDuration =
                      RealtimePlayingInfos.current!.audio.duration;
                  final songNowPosition = RealtimePlayingInfos.currentPosition;
                  return Padding(
                    padding: EdgeInsets.fromLTRB(
                        mqwidth * 0.07, 0, mqwidth * 0.07, 0),
                    child: ProgressBar(
                      // progressBarColor: Colors.redAccent,
                      // baseBarColor: Color.fromARGB(179, 135, 81, 81),
                      //thumbColor: Color.fromARGB(255, 6, 5, 5),
                      progress: songNowPosition,
                      // thumbGlowColor: Colors.deepOrange,
                      thumbGlowRadius: 15,
                      thumbRadius: 7,
                      barHeight: 3,
                      timeLabelPadding: mqheight * 0.004,
                      total: songDuration,
                      onSeek: (songDuration) => player.seek(songDuration),
                      // timeLabelTextStyle: const TextStyle(color: Colors.white),
                    ),
                  );
                },
              ),

//------------------------------------------progress bar ----------------------------------------------------//

              SizedBox(
                height: mqheight * .03,
              ),
              Padding(
                padding:
                    EdgeInsets.fromLTRB(mqwidth * .05, 0, mqwidth * .05, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {
                        // setState(() {});
                        player.toggleShuffle();
                      },
                      icon: player.isShuffling.value
                          ? const Icon(
                              Icons.shuffle,
                              color: Colors.teal,
                            )
                          : const Icon(
                              Icons.shuffle,
                              // color: Colors.white,
                            ),
                    ),

//--------------------------------------------Shuffle----------------------------------------------------------//

                    PlayerBuilder.isPlaying(
                      player: player,
                      builder: (context, isPlaying) {
                        return IconButton(
                          onPressed: playing.index == 0
                              ? () {}
                              : () async {
                                  await player.previous();
                                  RecentlyModel preRecSong;
                                  preRecSong = RecentlyModel(
                                    recentSongName:
                                        nowRecentSong[playing.index - 1]
                                            .songName,
                                    recentArtists:
                                        nowRecentSong[playing.index - 1]
                                            .artists,
                                    recentDuration:
                                        nowRecentSong[playing.index - 1]
                                            .duration,
                                    recentSongurl:
                                        nowRecentSong[playing.index - 1]
                                            .songurl,
                                    recentId:
                                        nowRecentSong[playing.index - 1].id,
                                  );
                                  updateRecentlyPlayed(
                                      preRecSong, playing.index - 1,context);
                                      BlocProvider.of<RecentlyPlayedBloc>(context).add(RecentShowListEvent());
                                  if (isPlaying == false) {
                                    player.pause();
                                    // setState(() {});
                                  }
                                },
                          icon: playing.index == 0
                              ? const Icon(
                                  Icons.skip_previous_rounded,
                                  color: Colors.black38,
                                  size: 35,
                                )
                              : const Icon(
                                  Icons.skip_previous_rounded,
                                  // color: Colors.white38,
                                ),
                          iconSize: 35,
                        );
                      },
                    ),

//------------------------------------------skipBack--------------------------------------------------------------//

                    Container(
                      height: mqheight * 0.08,
                      width: mqwidth * 0.2,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.blueAccent,
                      ),
                      child: Center(
                        child: PlayerBuilder.isPlaying(
                          player: player,
                          builder: (context, isPlaying) {
                            return IconButton(
                              onPressed: () {
                                player.playOrPause();
                              },
                              icon: Icon(isPlaying == true
                                  ? Icons.pause_rounded
                                  : Icons.play_arrow_rounded),
                              iconSize: 40,
                              splashRadius: 800,
                              splashColor: Colors.pinkAccent,
                            );
                          },
                        ),
                      ),
                    ),

//-----------------------------------------------------PlayPause-------------------------------------------------------//

                    PlayerBuilder.isPlaying(
                      player: player,
                      builder: (context, isPlaying) {
                        return IconButton(
                          onPressed: playing.index ==
                                  playing.playlist.audios.length - 1
                              ? () {}
                              : () async {
                                  await player.next();

                                  RecentlyModel nextRecSong;
                                  nextRecSong = RecentlyModel(
                                      recentSongName:
                                          nowRecentSong[playing.index + 1]
                                              .songName,
                                      recentArtists:
                                          nowRecentSong[playing.index + 1]
                                              .artists,
                                      recentDuration:
                                          nowRecentSong[playing.index + 1]
                                              .duration,
                                      recentSongurl:
                                          nowRecentSong[playing.index + 1]
                                              .songurl,
                                      recentId:
                                          nowRecentSong[playing.index + 1].id);
                                  updateRecentlyPlayed(
                                      nextRecSong, playing.index + 1,context);
                                      BlocProvider.of<RecentlyPlayedBloc>(context).add(RecentShowListEvent());
                                  if (isPlaying == false) {
                                    player.pause();
                                    //  setState(() {});
                                  }
                                },
                          icon: playing.index ==
                                  playing.playlist.audios.length - 1
                              ? const Icon(
                                  Icons.skip_next_rounded,
                                   color: Colors.black38,
                                  size: 35,
                                )
                              : const Icon(
                                  Icons.skip_next_rounded,
                                  //color: Colors.white,
                                  size: 35,
                                ),
                        );
                      },
                    ),

//----------------------------------------------------skipToNext---------------------------------------------------//

                    IconButton(
                      onPressed: () {
                        if (isRepeat) {
                          player.setLoopMode(LoopMode.none);
                          isRepeat = false;
                        } else {
                          player.setLoopMode(LoopMode.single);
                          isRepeat = true;
                        }
                        // setState(() {});
                      },
                      icon: isRepeat
                          ? const Icon(
                              Icons.repeat_sharp,
                              color: Colors.tealAccent,
                              size: 27,
                            )
                          : const Icon(
                              Icons.repeat_sharp,
                              // color: Colors.white,
                              size: 27,
                            ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
