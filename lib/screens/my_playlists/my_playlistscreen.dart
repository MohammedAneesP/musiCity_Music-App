import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musi_city/application/playlist_list/playlist_listing_bloc.dart';
import 'package:musi_city/constants/playlist_title.dart';
import 'package:musi_city/functions/box_opening.dart';
import 'package:musi_city/functions/functions.dart';
import 'package:musi_city/models/playlist_model.dart';
import 'package:musi_city/screens/my_playlists/createdplaylist.dart';

import 'widgets/playlist_create_button.dart';
import 'widgets/playlist_delete_button.dart';

class MyPlaylist extends StatelessWidget {
  MyPlaylist({super.key});
  TextEditingController playlistNameController = TextEditingController();

  TextEditingController playlistNameEditor = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final editorFormKey = GlobalKey<FormState>();

  List<PlaylistModel> listOfPlaylists = [];

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<PlaylistListingBloc>(context).add(PlayListShow());
    });
    final mqheight = MediaQuery.of(context).size.height;
    final mqwidth = MediaQuery.of(context).size.width;

    return Scaffold(
      floatingActionButton: Padding(
        padding: EdgeInsets.fromLTRB(0, 0, mqwidth * 0.05, mqheight * 0.03),
        child: PlaylistCreateButton(
            formKey: formKey, playlistNameController: playlistNameController),
      ),
      body: SafeArea(
        child: Column(
          children: [
            PlaylistTitle(mqheight: mqheight, mqwidth: mqwidth),
            SizedBox(height: mqheight * 0.05),
            Expanded(
              child: SizedBox(
                child: BlocBuilder<PlaylistListingBloc, PlaylistListingState>(
                  builder: (context, state) {
                    List<PlaylistModel> playlistNameList =
                        state.anNewPlayList.toList();
                    if (playlistNameList.isEmpty) {
                      return const Center(
                        child: Text(
                          "No Playlist Created yet",
                          style: defaultTextStyle,
                        ),
                      );
                    } else {
                      return ListView.separated(
                        itemBuilder: (context, index) {
                          PlaylistModel fullPlaylist = playlistNameList[index];
                          return ListTile(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return PlaylistCreated(
                                      allPlaylistSong:
                                          playlistNameList[index].playlistSongs,
                                      crntPlaylstName:
                                          playlistNameList[index].playlistName,
                                      playlistIndex: index,
                                    );
                                  },
                                ),
                              );
                            },
                            title: Text(
                              fullPlaylist.playlistName,
                              style: songNameStyle,
                            ),
                            trailing: PopupMenuButton(
                              icon: const Icon(
                                Icons.more_vert_sharp,
                              ),
                              itemBuilder: (context) {
                                return [
                                  PopupMenuItem(
                                    value: 1,
                                    child: const Text("Delete"),
                                    onTap: () {
                                      OntapDelete(index, context);
                                    },
                                  ),
                                  PopupMenuItem(
                                    child: const Text("Edit"),
                                    onTap: () {
                                      playlistNameEditor =
                                          playlistNameController;

                                      Future.delayed(
                                        const Duration(seconds: 0),
                                        () => showDialog(
                                          context: context,
                                          builder: (context) {
                                            playlistNameEditor =
                                                TextEditingController(
                                                    text: state
                                                        .anNewPlayList[index]
                                                        .playlistName);
                                            return AlertDialog(
                                              title: const Text(
                                                "Rename Your Plalist",
                                              ),
                                              content: Form(
                                                key: editorFormKey,
                                                child: TextFormField(
                                                  controller:
                                                      playlistNameEditor,
                                                  decoration:
                                                      const InputDecoration(
                                                    border: OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: Colors.black),
                                                    ),
                                                  ),
                                                  validator: (value) {
                                                    List<PlaylistModel>
                                                        editValid = myPlaylist
                                                            .values
                                                            .toList();
                                                    bool isAlreadyThere = editValid
                                                        .where((element) =>
                                                            element
                                                                .playlistName ==
                                                            value!.trim())
                                                        .isNotEmpty;

                                                    if (value!.trim().isEmpty) {
                                                      return "Name required";
                                                    }
                                                    if (isAlreadyThere) {
                                                      return "Existing Name";
                                                    } else {
                                                      return null;
                                                    }
                                                  },
                                                ),
                                              ),
                                              actions: [
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: const Text("Cancel"),
                                                ),
                                                TextButton(
                                                  onPressed: () {
                                                    final isValid =
                                                        editorFormKey
                                                            .currentState!
                                                            .validate();
                                                    if (isValid) {
                                                      myPlaylist.putAt(
                                                        index,
                                                        PlaylistModel(
                                                          playlistName:
                                                              playlistNameEditor
                                                                  .text,
                                                          playlistSongs: [],
                                                        ),
                                                      );
                                                      Navigator.pop(context);
                                                    }
                                                  },
                                                  child: const Text("submit"),
                                                ),
                                              ],
                                            );
                                          },
                                        ),
                                      );
                                    },
                                  ),
                                ];
                              },
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return const Divider();
                        },
                        itemCount: playlistNameList.length,
                      );
                    }
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
