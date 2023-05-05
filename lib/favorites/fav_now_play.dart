// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:musi_city/functions/box_opening.dart';
import 'package:musi_city/main.dart';
import 'package:musi_city/models/favorite_model.dart';
import 'package:musi_city/models/home_models.dart';

class FavNowPlayButton extends StatelessWidget{
  int index;
  FavNowPlayButton({super.key, required this.index});
  List<FavoriteModel> favButtunSongList = [];

   List<AllSong> favButtonAllSongs = allSongList.values.toList();
  

  

  @override
  Widget build(BuildContext context) {
    favButtunSongList = favoriteSong.values.toList();
    return favButtunSongList
            .where((element) =>
                element.favSongName == favButtonAllSongs[index].songName)
            .isEmpty
        ? IconButton(
            onPressed: () {
              favoriteSong.add(
                FavoriteModel(
                    favSongName: favButtonAllSongs[index].songName,
                    favSongArtist: favButtonAllSongs[index].artists,
                    favSongDuration: favButtonAllSongs[index].duration,
                    favSongUrl: favButtonAllSongs[index].songurl,
                    favSongId: favButtonAllSongs[index].id),
              );
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("added to Favorites"),
                  behavior: SnackBarBehavior.floating,
                  duration: Duration(seconds: 2),
                ),
              );
           
            },
            icon: const Icon(
              Icons.favorite_border_sharp,
              //color: Colors.white,
              size: 30,
            ),
          )
        : IconButton(
            onPressed: () {
              int favNowPlaysong = favButtunSongList.indexWhere((element) =>
                  element.favSongId == favButtonAllSongs[index].id);
              favoriteSong.deleteAt(favNowPlaysong);

              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Removed from Favorites"),
                  behavior: SnackBarBehavior.floating,
                  duration: Duration(seconds: 2),
                ),
              );
         
            },
            icon: Icon(
              Icons.favorite_sharp,
              color: Colors.redAccent[400],
              size: 30,
            ),
          );
  }
}
