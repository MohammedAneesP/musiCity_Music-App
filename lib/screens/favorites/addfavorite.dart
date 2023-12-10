// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musi_city/application/favorite_list/favorite_list_bloc.dart';
import 'package:musi_city/functions/box_opening.dart';
import 'package:musi_city/functions/functions.dart';
import 'package:musi_city/main.dart';
import 'package:musi_city/models/favorite_model.dart';
import 'package:musi_city/models/home_models.dart';

// ignore: must_be_immutable
class AddToFavorite extends StatelessWidget {
  int index;
  AddToFavorite({super.key, required this.index});
  List<AllSong> forFavAllSong = allSongList.values.toList();
  List<FavoriteModel> favorites = [];

  @override
  Widget build(BuildContext context) {
    favorites = favoriteSong.values.toList();
    return favorites
            .where((element) =>
                element.favSongName == forFavAllSong[index].songName)
            .isEmpty
        ? TextButton(
            onPressed: () {
              favoriteSong.add(
                FavoriteModel(
                  favSongName: forFavAllSong[index].songName,
                  favSongArtist: forFavAllSong[index].artists,
                  favSongDuration: forFavAllSong[index].duration,
                  favSongUrl: forFavAllSong[index].songurl,
                  favSongId: forFavAllSong[index].id,
                ),
              );
              
              BlocProvider.of<FavoriteListBloc>(context).add(FavListingScreen());
              Navigator.pop(context);
              SnackAddDeleteMsg("Added to Favorite's", context);
            },
            child: const Text(
              "Add to Favorite",
              style: songNameStyle,
            ),
          )
        : TextButton(
            onPressed: () async {
              int currntFavSong = favorites.indexWhere((element) =>
                  element.favSongId == forFavAllSong[index].id);
              await favoriteSong.deleteAt(currntFavSong);

              SnackAddDeleteMsg("Revomed", context);
              Navigator.pop(context);
            },
            child: const Text(
              "Remove From Favorite's",
              style: songNameStyle,
            ),
          );
  }
}
