import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:musi_city/functions/box_opening.dart';
import 'package:musi_city/functions/functions.dart';
import 'package:musi_city/models/home_models.dart';
import 'package:musi_city/nowPlaying/nowplaying_screen.dart';
import 'package:on_audio_query/on_audio_query.dart' hide PlaylistModel;
import '../models/playlist_model.dart';

class PlaylistCreated extends StatefulWidget {
  PlaylistCreated(
      {super.key,
      required this.allPlaylistSong,
      required this.crntPlaylstName,
      required this.playlistIndex});
  List<AllSong> allPlaylistSong = [];
  String crntPlaylstName;
  int playlistIndex;

  @override
  State<PlaylistCreated> createState() => _PlaylistCreatedState();
}

class _PlaylistCreatedState extends State<PlaylistCreated> {
  List<Audio> playlistConvrtAudio = [];
  final AssetsAudioPlayer playlistAudioPlyr = AssetsAudioPlayer.withId("0");

  @override
  void initState() {
    for (var item in widget.allPlaylistSong) {
      playlistConvrtAudio.add(
        Audio.file(
          item.songurl,
          metas: Metas(
              title: item.songName,
              artist: item.artists,
              id: item.id.toString()),
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
     // backgroundColor: musiCityBgColor,
      body: Column(
        children: [
          SizedBox(
            height: mqheight * 0.05,
          ),
          SizedBox(
            height: mqheight * .05,
            child: Padding(
              padding: EdgeInsets.fromLTRB(0,0,mqwidth*0.65,0,),
              child: Text(widget.crntPlaylstName, style: headingStyle,overflow: TextOverflow.ellipsis,),
            ),
          ),
          Expanded(
            child: SizedBox(
              child: ValueListenableBuilder(
                valueListenable: myPlaylist.listenable(),
                builder: (BuildContext, Box<PlaylistModel> playlistModelOb, _) {
                  List<PlaylistModel> createdScreenPlay =
                      myPlaylist.values.toList();
                  List<AllSong> createdPlaySong =
                      createdScreenPlay[widget.playlistIndex].playlistSongs;
                  if (createdPlaySong.isEmpty) {
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
                                backgroundImage: AssetImage(
                                    leadingImage),
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
                                setState(
                                  () {
                                    createdPlaySong.removeWhere((element) =>
                                        element.id ==
                                        createdPlaySong[index].id);
                                    playlistConvrtAudio.removeAt(index);
                                  },
                                );
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
                        itemCount: createdPlaySong.length);
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
