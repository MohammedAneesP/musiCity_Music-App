import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:musi_city/functions/box_opening.dart';
import 'package:musi_city/functions/functions.dart';
import 'package:musi_city/nowPlaying/nowplaying_screen.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../models/favorite_model.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  List<Audio> favConvertAudio = [];
  final AssetsAudioPlayer favAudioPlayer = AssetsAudioPlayer.withId("0");

  @override
  void initState() {
    List<FavoriteModel> allFavDbSong = favoriteSong.values.toList();
    for (var favItem in allFavDbSong) {
      favConvertAudio.add(
        Audio.file(
          favItem.favSongUrl,
          metas: Metas(
            title: favItem.favSongName,
            artist: favItem.favSongArtist,
            id: favItem.favSongId.toString(),
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
     // backgroundColor: musiCityBgColor,
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(mqwidth * 0.05, mqheight * 0.05, 0, 0),
            child: Text(
              "Favorite's",
              style: headingStyle,
            ),
          ),
          Expanded(
            child: SizedBox(
              child: ValueListenableBuilder(
                valueListenable: favoriteSong.listenable(),
                builder:
                    // ignore: avoid_types_as_parameter_names, non_constant_identifier_names
                    (BuildContext, Box<FavoriteModel> favoriteSongPlay, child) {
                  List<FavoriteModel> allFavSong =
                      favoriteSongPlay.values.toList();
                  if (allFavSong.isEmpty) {
                    return  Center(
                      child: Text("No favorite's Yet...!",style: defaultTextStyle),
                    );
                  }
                  return ListView.separated(
                      itemBuilder: (context, index) {
                        FavoriteModel favSongList = allFavSong[index];
                        return InkWell(
                          onTap: () {
                            favAudioPlayer.open(
                              Playlist(
                                  audios: favConvertAudio, startIndex: index),
                              loopMode: LoopMode.playlist,
                              showNotification: true,
                              headPhoneStrategy:
                                  HeadPhoneStrategy.pauseOnUnplug,
                            );
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) =>
                                    NowPlayingScreeen(currentPlayIndex: index),
                              ),
                            );
                          },
                          child: Container(
                            //decoration: conatainerDecoration,
                            child: ListTile(
                              leading: QueryArtworkWidget(
                                id: favSongList.favSongId,
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
                                favSongList.favSongName,
                                style: songNameStyle,
                                overflow: TextOverflow.ellipsis,
                              ),
                              subtitle: Text(
                                favSongList.favSongArtist,
                                style: songNameStyle,
                                overflow: TextOverflow.ellipsis,
                              ),
                              trailing: IconButton(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title:
                                            const Text("Remove this Song..."),
                                        content: const Text("Are you Sure..?"),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: const Text("Cancel"),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              setState(
                                                () {
                                                  favConvertAudio.removeAt(index);
                                                  favoriteSong.deleteAt(index);
                                                  Navigator.pop(context);
                                                },
                                              );
                                            },
                                            child: const Text("Yes"),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.white70,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const Divider();
                      },
                      itemCount: allFavSong.length);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

List listOfFavoriteSong = [
  "Track 1",
  "Track 2",
  "Track 3",
  "Track 4",
  "Track 5",
];

List listofFavritSongSubtitle = [
  "Artist 1",
  "Artist 2",
  "Artist 3",
  "Artist 4",
  "Artist 5",
];
