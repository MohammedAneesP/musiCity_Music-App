import 'package:flutter/material.dart';
import 'package:musi_city/functions/box_opening.dart';
import 'package:musi_city/functions/functions.dart';
import 'package:musi_city/main.dart';
import 'package:musi_city/models/favorite_model.dart';
import 'package:musi_city/models/home_models.dart';

// ignore: must_be_immutable
class AddToFavorite extends StatefulWidget {
  int index;
  AddToFavorite({super.key, required this.index});

  @override
  State<AddToFavorite> createState() => _AddToFavoriteState();
}

class _AddToFavoriteState extends State<AddToFavorite> {
  late List<AllSong> forFavAllSong;
  List<FavoriteModel> favorites = [];
  @override
  void initState() {
    forFavAllSong = allSongList.values.toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    favorites = favoriteSong.values.toList();
    return favorites
            .where((element) =>
                element.favSongName == forFavAllSong[widget.index].songName)
            .isEmpty
        ? TextButton(
            onPressed: () {
              favoriteSong.add(
                FavoriteModel(
                  favSongName: forFavAllSong[widget.index].songName,
                  favSongArtist: forFavAllSong[widget.index].artists,
                  favSongDuration: forFavAllSong[widget.index].duration,
                  favSongUrl: forFavAllSong[widget.index].songurl,
                  favSongId: forFavAllSong[widget.index].id,
                ),
              );
              Navigator.pop(context);
              SnackAddDeleteMsg("Added to Favorite's", context);
            },
            child: Text(
              "Add to Favorite",
              style: songNameStyle,
            ),
          )
        : TextButton(
            onPressed: () async {
              int currntFavSong = favorites.indexWhere((element) =>
                  element.favSongId == forFavAllSong[widget.index].id);
              await favoriteSong.deleteAt(currntFavSong);

              SnackAddDeleteMsg("Revomed", context);
              Navigator.pop(context);
            },
            child: Text(
              "Remove From Favorite's",
              style: songNameStyle,
            ),
          );
  }
}
