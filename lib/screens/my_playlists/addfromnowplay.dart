import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musi_city/application/playlist_list/playlist_listing_bloc.dart';
import 'package:musi_city/application/theme_changer/theme_changer_bloc.dart';
import 'package:musi_city/functions/box_opening.dart';
import 'package:musi_city/functions/functions.dart';
import 'package:musi_city/main.dart';
import 'package:musi_city/models/home_models.dart';
import 'package:musi_city/models/playlist_model.dart';

import 'widgets/add_playlist_button.dart';

class AddFromNowPlay extends StatelessWidget {
  int songIndex;
  AddFromNowPlay({super.key, required this.songIndex});

  TextEditingController playlistNameController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<PlaylistListingBloc>(context).add(PlayListShow());
    });
    final mqheight = MediaQuery.of(context).size.height;
    final mqWidth = MediaQuery.of(context).size.width;

    return IconButton(
      onPressed: () async {
        await showModalBottomSheet(
          backgroundColor: Colors.transparent,
          context: context,
          builder: (context) {
            return BlocBuilder<ThemeChangerBloc, ThemeChangerState>(
              builder: (context, state) {
                return Container(
                  height: mqheight * 0.4,
                  decoration: BoxDecoration(
                      color: state.anTheme.scaffoldBackgroundColor,
                      borderRadius: BorderRadius.circular(20)),
                  child: Column(
                    children: [
                      BlocBuilder<PlaylistListingBloc, PlaylistListingState>(
                        builder: (context, state) {
                          if (state.anNewPlayList.isEmpty) {
                            return Column(
                              children: [
                                SizedBox(height: mqheight * 0.01),
                                const Text(
                                  "Playlist not created",
                                  style: defaultTextStyle,
                                ),
                                const Divider(),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(250, 220, 0, 0),
                                  child: AddPlaylistHome(
                                      formKey: formKey,
                                      playlistNameController:
                                          playlistNameController),
                                ),
                              ],
                            );
                          } else {
                            return Column(
                              children: [
                                SizedBox(height: mqheight * 0.01),
                                const Text("Playlists",
                                    style: defaultTextStyle),
                                const Divider(),
                                SizedBox(
                                  height: mqheight * 0.33,
                                  child: Stack(
                                    children: [
                                      ListView.separated(
                                        shrinkWrap: true,
                                        itemBuilder: (context, index) {
                                          return InkWell(
                                            onTap: () {},
                                            child: ListTile(
                                              leading: const Icon(
                                                Icons.library_music_sharp,
                                                // color: whiteColor,
                                              ),
                                              title: Text(
                                                state.anNewPlayList[index]
                                                    .playlistName,
                                                style: songNameStyle,
                                              ),
                                              onTap: () {
                                                PlaylistModel? playSongName =
                                                    myPlaylist.getAt(index);
                                                List<AllSong>?
                                                    playlistSongdata =
                                                    playSongName!.playlistSongs;
                                                List<AllSong> totalSongs =
                                                    allSongList.values.toList();

                                                bool isAlreadyAdded =
                                                    playlistSongdata.any(
                                                        (element) =>
                                                            element.id ==
                                                            totalSongs[
                                                                    songIndex]
                                                                .id);
                                                if (isAlreadyAdded == false) {
                                                  playlistSongdata.add(
                                                    AllSong(
                                                        songName: totalSongs[
                                                                songIndex]
                                                            .songName,
                                                        artists: totalSongs[
                                                                songIndex]
                                                            .artists,
                                                        duration: totalSongs[
                                                                songIndex]
                                                            .duration,
                                                        songurl: totalSongs[
                                                                songIndex]
                                                            .songurl,
                                                        id: totalSongs[
                                                                songIndex]
                                                            .id),
                                                  );
                                                  myPlaylist.putAt(
                                                    index,
                                                    PlaylistModel(
                                                      playlistName: state
                                                          .anNewPlayList[index]
                                                          .playlistName,
                                                      playlistSongs:
                                                          playlistSongdata,
                                                    ),
                                                  );
                                                  SnackAddDeleteMsg(
                                                      "Added to playlist",
                                                      context);
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
                                            thickness: .8,
                                            // color: whiteColor,
                                          );
                                        },
                                        itemCount: myPlaylist.length,
                                      ),
                                      Positioned(
                                        top: mqheight * 0.25,
                                        left: mqWidth * 0.8,
                                        child: AddPlaylistHome(
                                          formKey: formKey,
                                          playlistNameController:
                                              playlistNameController,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
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
        );
      },
      icon: const Icon(
        Icons.add,
        size: 30,
      ),
    );
  }
}
