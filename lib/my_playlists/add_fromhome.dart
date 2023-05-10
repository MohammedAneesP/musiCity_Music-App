// ignore_for_file: must_be_immutable, avoid_types_as_parameter_names, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:musi_city/application/playlist_list/playlist_listing_bloc.dart';
import 'package:musi_city/functions/box_opening.dart';
import 'package:musi_city/functions/functions.dart';
import 'package:musi_city/main.dart';
import 'package:musi_city/models/home_models.dart';
import 'package:musi_city/models/playlist_model.dart';

class AddFromHomePlaylist extends StatelessWidget {
  int songIndex;
  AddFromHomePlaylist({super.key, required this.songIndex});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<PlaylistListingBloc>(context).add(PlayListShow());
    });
    final mqheight = MediaQuery.of(context).size.height;
    // final mqwidth = MediaQuery.of(context).size.width;
    return TextButton(
      onPressed: () async {
        await showModalBottomSheet(
          context: context,
          builder: (context) {
            return SizedBox(
              height: mqheight * 0.4,
              // color: const Color.fromARGB(255, 45, 13, 13),
              // child: ValueListenableBuilder(
              //   valueListenable: myPlaylist.listenable(),
              //   // ignore: non_constant_identifier_names
              //   builder: (BuildContext, Box<PlaylistModel> addfromHomeplay, _) {
              // List<PlaylistModel> addPlaylistName =
              //     addfromHomeplay.values.toList();
              child: BlocBuilder<PlaylistListingBloc, PlaylistListingState>(
                builder: (context, state) {
                if (state.anNewPlayList.isEmpty) {
                    return Center(
                      child: Text(
                        "Playlist not created",
                        style: defaultTextStyle,
                      ),
                    );
                  } else {
                    return Column(
                      children: [
                        SizedBox(
                          height: mqheight * 0.1,
                          child: Text("My Playlist's", style: defaultTextStyle),
                        ),
                        Expanded(
                          child: SizedBox(
                            child: ListView.separated(
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: () {},
                                    child: ListTile(
                                      leading: const Icon(
                                        Icons.library_music_sharp,
                                        //color: whiteColor,
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
                                                totalSongs[songIndex]
                                                    .id);
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
                                                    .id,),
                                          );
                                          myPlaylist.put(
                                            index,
                                            PlaylistModel(
                                              playlistName:
                                                  playSongName.playlistName,
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
                                    // color: whiteColor,
                                    indent: 20,
                                    endIndent: 20,
                                  );
                                },
                                itemCount: myPlaylist.length),
                          ),
                        ),
                      ],
                    );
                  }
                },
              ),
            );
          },
        );
        Navigator.pop(context);
      },
      child: Text(
        "Add to Playlist",
        style: songNameStyle,
      ),
    );
  }
}
