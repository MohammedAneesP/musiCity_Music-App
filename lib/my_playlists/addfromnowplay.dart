import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musi_city/application/playlist_list/playlist_listing_bloc.dart';
import 'package:musi_city/functions/functions.dart';
import '../functions/box_opening.dart';
import '../main.dart';
import '../models/home_models.dart';
import '../models/playlist_model.dart';

class AddFromNowPlay extends StatelessWidget {
  int songIndex;
  AddFromNowPlay({super.key, required this.songIndex});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<PlaylistListingBloc>(context).add(PlayListShow());
    });
    final mqheight = MediaQuery.of(context).size.height;

    return IconButton(
      onPressed: () async {
        await showModalBottomSheet(
          context: context,
          builder: (context) {
            return SizedBox(
              height: mqheight * 0.4,
              //color: const Color.fromARGB(255, 45, 13, 13),
              child: Column(
                children: [
                  Text("My Playlist's", style: defaultTextStyle),
                  // ValueListenableBuilder(
                  //   valueListenable: myPlaylist.listenable(),
                  //   builder:
                  //       (BuildContext, Box<PlaylistModel> addfromHomeplay, _) {
                  // List<PlaylistModel> addPlaylistName =
                  //     addfromHomeplay.values.toList();
                  BlocBuilder<PlaylistListingBloc, PlaylistListingState>(
                    builder: (context, state) {
                       if (state.anNewPlayList.isEmpty) {
                        return Center(
                          child: Text(
                            "Playlist not created",
                            style: defaultTextStyle,
                          ),
                        );
                      } else {
                        return Expanded(
                          child: ListView.separated(
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {},
                                  child: ListTile(
                                    leading: const Icon(
                                      Icons.library_music_sharp,
                                      // color: whiteColor,
                                    ),
                                    title: Text(
                                      state.anNewPlayList[index].playlistName,
                                      style: songNameStyle,
                                    ),
                                    onTap: () {
                                      PlaylistModel? playSongName =
                                          myPlaylist.getAt(index);
                                      List<AllSong>? playlistSongdata =
                                          playSongName!.playlistSongs;
                                      List<AllSong> totalSongs =
                                          allSongList.values.toList();

                                      bool isAlreadyAdded =
                                          playlistSongdata.any((element) =>
                                              element.id ==
                                              totalSongs[songIndex].id);
                                      if (isAlreadyAdded == false) {
                                        playlistSongdata.add(
                                          AllSong(
                                              songName:
                                                  totalSongs[songIndex]
                                                      .songName,
                                              artists:
                                                  totalSongs[songIndex]
                                                      .artists,
                                              duration:
                                                  totalSongs[songIndex]
                                                      .duration,
                                              songurl:
                                                  totalSongs[songIndex]
                                                      .songurl,
                                              id: totalSongs[songIndex]
                                                  .id),
                                        );
                                        myPlaylist.putAt(
                                          index,
                                          PlaylistModel(
                                            playlistName: state.anNewPlayList[index]
                                                .playlistName,
                                            playlistSongs: playlistSongdata,
                                          ),
                                        );
                                        SnackAddDeleteMsg(
                                            "Added to playlist", context);
                                      } else {
                                        SnackAddDeleteMsg(
                                            "Already exist", context);
                                      }
                                      Navigator.pop(context);
                                    },
                                  ),
                                );
                              },
                              separatorBuilder: (context, index) {
                                return const Divider(
                                  thickness: 1,
                                  // color: whiteColor,
                                );
                              },
                              itemCount: myPlaylist.length),
                        );
                      }
                    },
                  )
                ],
              ),
            );
          },
        );
      },
      icon: const Icon(
        Icons.add,
        // color: whiteColor,
        size: 30,
      ),
    );
  }
}
