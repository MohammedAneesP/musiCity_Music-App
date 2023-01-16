import 'package:flutter/material.dart';
import 'package:musi_city/functions/box_opening.dart';
import 'package:musi_city/main.dart';
import 'package:musi_city/models/favorite_model.dart';
import 'package:musi_city/models/home_models.dart';

class FavNowPlayButton extends StatefulWidget {
  int index;
  FavNowPlayButton({super.key, required this.index});

  @override
  State<FavNowPlayButton> createState() => _FavNowPlayButtonState();
}

class _FavNowPlayButtonState extends State<FavNowPlayButton> {
  late List<AllSong> favButtonAllSongs;
  List<FavoriteModel> favButtunSongList = [];

  @override
  void initState() {
    favButtonAllSongs = allSongList.values.toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    favButtunSongList = favoriteSong.values.toList();
    return favButtunSongList
            .where((element) =>
                element.favSongName == favButtonAllSongs[widget.index].songName)
            .isEmpty
        ? IconButton(
            onPressed: () {
              favoriteSong.add(
                FavoriteModel(
                    favSongName: favButtonAllSongs[widget.index].songName,
                    favSongArtist: favButtonAllSongs[widget.index].artists,
                    favSongDuration: favButtonAllSongs[widget.index].duration,
                    favSongUrl: favButtonAllSongs[widget.index].songurl,
                    favSongId: favButtonAllSongs[widget.index].id),
              );
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("added to Favorites"),
                  behavior: SnackBarBehavior.floating,
                  duration: Duration(seconds: 2),
                ),
              );
              setState(() {});
            },
            icon: const Icon(
              Icons.favorite_border_sharp,
              //color: Colors.white,
              size: 30,
            ))
        : IconButton(
            onPressed: () {
              int favNowPlaysong = favButtunSongList.indexWhere((element) =>
                  element.favSongId == favButtonAllSongs[widget.index].id);
              favoriteSong.deleteAt(favNowPlaysong);
              
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Removed from Favorites"),
                  behavior: SnackBarBehavior.floating,
                  duration: Duration(seconds: 2),
                ),
              );
              setState(() {});
            },
            icon:  Icon(
              Icons.favorite_sharp,
              color: Colors.redAccent[400],
              size: 30,
            ),
          );
  }
}
