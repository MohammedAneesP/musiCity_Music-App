import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musi_city/application/favorite_list/favorite_list_bloc.dart';
import 'package:musi_city/functions/box_opening.dart';
import 'package:musi_city/functions/functions.dart';
import 'package:musi_city/nowPlaying/nowplaying_screen.dart';
import 'package:on_audio_query/on_audio_query.dart';



class FavoritesScreen extends StatelessWidget {
  FavoritesScreen({super.key});

  List<Audio> favAudioConvrt = [];

  final AssetsAudioPlayer favAudioPlayer = AssetsAudioPlayer.withId("0");

//   @override
//   State<FavoritesScreen> createState() => _FavoritesScreenState();
// }

// class _FavoritesScreenState extends State<FavoritesScreen> {
//   List<Audio> favConvertAudio = [];

//   @override
//   void initState() {
//     List<FavoriteModel> allFavDbSong = favoriteSong.values.toList();
//     for (var favItem in allFavDbSong) {
//       favConvertAudio.add(
//         Audio.file(
//           favItem.favSongUrl,
//           metas: Metas(
//             title: favItem.favSongName,
//             artist: favItem.favSongArtist,
//             id: favItem.favSongId.toString(),
//           ),
//         ),
//       );
//     }
//     super.initState();
//   }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<FavoriteListBloc>(context).add(FavListingScreen());
    });
    final mqheight = MediaQuery.of(context).size.height;
    final mqwidth = MediaQuery.of(context).size.width;

    return Scaffold(
      // backgroundColor: musiCityBgColor,
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(mqwidth * 0.05, mqheight * 0.05, 0, 0),
            child: Container(
              height: mqheight * 0.1,
              width: mqwidth * 0.8,
              decoration: const BoxDecoration(
                //  color: Colors.amber,
                image: DecorationImage(
                  image: AssetImage('assets/favorite.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Expanded(
            child: SizedBox(
              // child: ValueListenableBuilder(
              //   valueListenable: favoriteSong.listenable(),
              //   builder:
              //       // ignore: avoid_types_as_parameter_names, non_constant_identifier_names
              //       (BuildContext, Box<FavoriteModel> favoriteSongPlay, child) {
              //     List<FavoriteModel> allFavSong =
              //         favoriteSongPlay.values.toList();

              //   },
              // ),
              child: BlocBuilder<FavoriteListBloc, FavoriteListState>(
                builder: (context, state) {
                  // for (var element in state.favStateList) {
                  //   favAudioConvrt.add(
                  //     Audio.file(
                  //       element.favSongUrl,
                  //       metas: Metas(
                  //         id: element.favSongId.toString(),
                  //         artist: element.favSongArtist,
                  //         title: element.favSongName,
                  //       ),
                  //     ),
                  //   );
                  // }
                  if (state.favStateList.isEmpty) {
                    return Center(
                      child: Text("No favorite's Yet...!",
                          style: defaultTextStyle),
                    );
                  }
                  return ListView.separated(
                      itemBuilder: (context, index) {
                        // FavoriteModel favSongList = state.favStateList[index];
                        return InkWell(
                          onTap: () {
                            favAudioPlayer.open(
                              Playlist(
                                  audios: state.favStateAudio,
                                  startIndex: index),
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
                          child: ListTile(
                            leading: QueryArtworkWidget(
                              id: state.favStateList[index].favSongId,
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
                              state.favStateList[index].favSongName,
                              style: songNameStyle,
                              overflow: TextOverflow.ellipsis,
                            ),
                            subtitle: Text(
                              state.favStateList[index].favSongArtist,
                              style: songNameStyle,
                              overflow: TextOverflow.ellipsis,
                            ),
                            trailing: IconButton(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: const Text("Remove this Song..."),
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
                                            state.favStateList.removeAt(index);
                                            favoriteSong.deleteAt(index);
                                            Navigator.pop(context);
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
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const Divider();
                      },
                      itemCount: state.favStateList.length);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
