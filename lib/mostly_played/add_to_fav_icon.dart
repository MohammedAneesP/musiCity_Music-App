import 'package:flutter/material.dart';
import 'package:musi_city/functions/box_opening.dart';
import 'package:musi_city/main.dart';
import 'package:musi_city/models/favorite_model.dart';
import 'package:musi_city/models/home_models.dart';
import '../functions/functions.dart';

class AddToFAvIcon extends StatefulWidget {
  int index;
  AddToFAvIcon({super.key, required this.index});

  @override
  State<AddToFAvIcon> createState() => _AddToFAvIconState();
}

class _AddToFAvIconState extends State<AddToFAvIcon> {
  late List<AllSong> forMostlyFavAdd;
  List<FavoriteModel> mostlyFavorite = [];

  @override
  void initState() {
    forMostlyFavAdd = allSongList.values.toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    mostlyFavorite = favoriteSong.values.toList();
    return mostlyFavorite
            .where((element) =>
                element.favSongName == forMostlyFavAdd[widget.index].songName)
            .isEmpty
        ? IconButton(
            onPressed: () {
              favoriteSong.add(
                FavoriteModel(
                  favSongName: forMostlyFavAdd[widget.index].songName,
                  favSongArtist: forMostlyFavAdd[widget.index].artists,
                  favSongDuration: forMostlyFavAdd[widget.index].duration,
                  favSongUrl: forMostlyFavAdd[widget.index].songurl,
                  favSongId: forMostlyFavAdd[widget.index].id,
                ),
              );
              setState(() {});
              //Navigator.pop(context);
              SnackAddDeleteMsg("Added to Favorite's", context);
            },
            icon:const Icon(
              Icons.favorite_outline_sharp,
             // color: whiteColor,
            ),
          )
        : IconButton(
            onPressed: () async {
              int curntFavMostPlySong = mostlyFavorite.indexWhere((element) =>
                  element.favSongId == forMostlyFavAdd[widget.index].id);
              await favoriteSong.deleteAt(curntFavMostPlySong);
              
              setState(() {});
              // ignore: use_build_context_synchronously
              SnackAddDeleteMsg("removed from favorite's", context);
            },
            icon: Icon(
              Icons.favorite_sharp,
              color: Colors.redAccent[400],
            ),
          );
  }
}
