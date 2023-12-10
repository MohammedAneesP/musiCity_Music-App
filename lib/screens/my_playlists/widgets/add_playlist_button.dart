
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musi_city/application/playlist_list/playlist_listing_bloc.dart';
import 'package:musi_city/functions/box_opening.dart';
import 'package:musi_city/functions/functions.dart';
import 'package:musi_city/models/playlist_model.dart';

class AddPlaylistHome extends StatelessWidget {
  const AddPlaylistHome({
    super.key,
    required this.formKey,
    required this.playlistNameController,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController playlistNameController;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      tooltip: "Create Playlist",
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text("Create Playlist"),
              content: Form(
                key: formKey,
                child: TextFormField(
                  controller: playlistNameController,
                  decoration: const InputDecoration(
                    hintText: "enter name",
                  ),
                  validator: (value) {
                    List<PlaylistModel> playListDetails =
                        myPlaylist.values.toList();
                    bool isAlreadyThere = playListDetails
                        .where(
                            (element) => element.playlistName == value!.trim())
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
                    final isValid = formKey.currentState!.validate();
                    if (isValid) {
                      myPlaylist.add(
                        PlaylistModel(
                          playlistName: playlistNameController.text,
                          playlistSongs: [],
                        ),
                      );
                      BlocProvider.of<PlaylistListingBloc>(context)
                          .add(PlayListShow());
                      SnackAddDeleteMsg("playlist created", context);
                      playlistNameController.clear();
                      Navigator.pop(context);
                    }
                  },
                  child: const Text("Save"),
                ),
              ],
            );
          },
        );
      },
      child: const Icon(Icons.add),
    );
  }
}
