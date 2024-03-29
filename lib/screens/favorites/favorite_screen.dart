import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musi_city/application/favorite_list/favorite_list_bloc.dart';
import 'package:musi_city/functions/box_opening.dart';
import 'package:musi_city/functions/functions.dart';
import 'package:musi_city/screens/now_playing/nowplaying_screen.dart';
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
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Favourite's",
          style: headingStyle,
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            
            Expanded(
              child: SizedBox(
                child: BlocBuilder<FavoriteListBloc, FavoriteListState>(
                  builder: (context, state) {
                    if (state.favStateList.isEmpty) {
                      return const Center(
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
                                  builder: (context) => NowPlayingScreeen(
                                      currentPlayIndex: index),
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
                                              state.favStateList
                                                  .removeAt(index);
                                              favoriteSong.deleteAt(index);
                                              BlocProvider.of<FavoriteListBloc>(
                                                      context)
                                                  .add(FavListingScreen());
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
      ),
    );
  }
}
