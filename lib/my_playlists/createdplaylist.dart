import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:musi_city/application/playlist_list/playlist_listing_bloc.dart';
import 'package:musi_city/functions/box_opening.dart';
import 'package:musi_city/functions/functions.dart';
import 'package:musi_city/models/home_models.dart';
import 'package:musi_city/nowPlaying/nowplaying_screen.dart';
import 'package:on_audio_query/on_audio_query.dart' hide PlaylistModel;
import '../models/playlist_model.dart';

class PlaylistCreated extends StatelessWidget {
  List<AllSong> allPlaylistSong = [];
  String crntPlaylstName;
  int playlistIndex;
  PlaylistCreated(
      {super.key,
      required this.allPlaylistSong,
      required this.crntPlaylstName,
      required this.playlistIndex});

  List<Audio> playlistConvrtAudio = [];
  final AssetsAudioPlayer playlistAudioPlyr = AssetsAudioPlayer.withId("0");

  // @override
  // void initState() {
  //   for (var item in widget.allPlaylistSong) {
  //     playlistConvrtAudio.add(
  //       Audio.file(
  //         item.songurl,
  //         metas: Metas(
  //           title: item.songName,
  //           artist: item.artists,
  //           id: item.id.toString(),
  //         ),
  //       ),
  //     );
  //   }
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<PlaylistListingBloc>(context).add(PlayListShow());
    });
    final mqheight = MediaQuery.of(context).size.height;
    final mqwidth = MediaQuery.of(context).size.width;

    return Scaffold(
      // backgroundColor: musiCityBgColor,
      body: Column(
        children: [
          SizedBox(
            height: mqheight * 0.05,
          ),
          SizedBox(
            height: mqheight * .05,
            child: Padding(
              padding: EdgeInsets.fromLTRB(0, 0, mqwidth * 0.65, 0),
              child: Text(
                crntPlaylstName,
                style: headingStyle,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          Expanded(
            child: SizedBox(
              // List<PlaylistModel> createdScreenPlay =
              //     myPlaylist.values.toList();

              child: BlocBuilder<PlaylistListingBloc, PlaylistListingState>(
                builder: (context, state) {
                  List<AllSong> createdPlaySong =
                      state.anNewPlayList[playlistIndex].playlistSongs.toList();
                  for (var element in createdPlaySong) {
                    playlistConvrtAudio.add(
                      Audio.file(
                        element.songurl,
                        metas: Metas(
                          title: element.songName,
                          artist: element.artists,
                          id: element.id.toString(),
                        ),
                      ),
                    );
                  }
                  if (state.anNewPlayList.isEmpty) {
                    return Center(
                      child: Text("Songs not added", style: defaultTextStyle),
                    );
                  } else {
                    return ListView.separated(
                      itemBuilder: (context, index) {
                        return ListTile(
                          onTap: () {
                            playlistAudioPlyr.open(
                              Playlist(
                                audios: playlistConvrtAudio,
                                startIndex: index,
                              ),
                              loopMode: LoopMode.playlist,
                              headPhoneStrategy:
                                  HeadPhoneStrategy.pauseOnUnplug,
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
                            id: createdPlaySong[index].id,
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
                            createdPlaySong[index].songName,
                            style: songNameStyle,
                            overflow: TextOverflow.ellipsis,
                          ),
                          subtitle: Text(
                            createdPlaySong[index].artists,
                            style: songNameStyle,
                            overflow: TextOverflow.ellipsis,
                          ),
                          trailing: IconButton(
                            onPressed: () {
                              // setState(
                              //   () {
                              createdPlaySong.removeWhere((element) =>
                                  element.id == createdPlaySong[index].id);
                              playlistConvrtAudio.removeAt(index);
                              //   },
                              // );
                              SnackAddDeleteMsg(
                                  "Removed from playlist", context);
                            },
                            icon: const Icon(
                              Icons.delete_rounded,
                              // color: whiteColor,
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) => const Divider(),
                      itemCount: state
                          .anNewPlayList[playlistIndex].playlistSongs.length,
                    );
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
