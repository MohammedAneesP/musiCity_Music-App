
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musi_city/application/playlist_list/playlist_listing_bloc.dart';
import 'package:musi_city/functions/box_opening.dart';
import 'package:musi_city/functions/functions.dart';

class OntapDelete {
  int index;
  OntapDelete(this.index, context) {
    Future.delayed(
      const Duration(seconds: 0),
      () => showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Do you want to Delete this playlist"),
            content: Text(areYouSure),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(noText),
              ),
              TextButton(
                onPressed: () {
                  myPlaylist.deleteAt(index);
                  BlocProvider.of<PlaylistListingBloc>(context)
                      .add(PlayListShow());
                  Navigator.pop(context);
                  SnackAddDeleteMsg("Playlist removed", context);
                },
                child: Text(yesText),
              ),
            ],
          );
        },
      ),
    );
  }
}
