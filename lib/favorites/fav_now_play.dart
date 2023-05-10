// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musi_city/application/fav_now_play_button/fav_now_play_button_bloc.dart';
import 'package:musi_city/application/favorite_list/favorite_list_bloc.dart';
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
  List<FavoriteModel> favButtunSongList = [];

  List<AllSong> favButtonAllSongs = allSongList.values.toList();

  @override
  Widget build(BuildContext context) {
    // log(index.toString());
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<FavNowPlayButtonBloc>(context).add(NowFavInitial());
    });
    favButtunSongList = favoriteSong.values.toList();
    return favButtunSongList
            .where((element) =>
                element.favSongName == favButtonAllSongs[widget.index].songName)
            .isEmpty
        ? BlocBuilder<FavNowPlayButtonBloc, FavNowPlayButtonState>(
            builder: (context, state) {
              //  log(index.toString());
              return IconButton(
                onPressed: () {
                  favoriteSong.add(
                    FavoriteModel(
                      favSongName: favButtonAllSongs[widget.index].songName,
                      favSongArtist: favButtonAllSongs[widget.index].artists,
                      favSongDuration: favButtonAllSongs[widget.index].duration,
                      favSongUrl: favButtonAllSongs[widget.index].songurl,
                      favSongId: favButtonAllSongs[widget.index].id,
                    ),
                  );
                 
                  BlocProvider.of<FavNowPlayButtonBloc>(context)
                      .add(NowFavInitial());
                  BlocProvider.of<FavoriteListBloc>(context)
                      .add(FavListingScreen());

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("added to Favorites"),
                      behavior: SnackBarBehavior.floating,
                      duration: Duration(seconds: 2),
                    ),
                  );
                  setState(() {});
                },
                icon: favButtunSongList
                        .where((element) =>
                            element.favSongName ==
                            favButtonAllSongs[widget.index].songName)
                        .isEmpty
                    ? const Icon(Icons.favorite_border)
                    : const Icon(
                        Icons.favorite,
                        color: Colors.redAccent,
                      ),
              );
            },
          )
        : BlocBuilder<FavNowPlayButtonBloc, FavNowPlayButtonState>(
            builder: (context, state) {
              
              return IconButton(
                onPressed: () {
                  int favNowPlaysong = favButtunSongList.indexWhere((element) =>
                      element.favSongId == favButtonAllSongs[widget.index].id);
                  favoriteSong.deleteAt(favNowPlaysong);
                 
                  BlocProvider.of<FavNowPlayButtonBloc>(context)
                      .add(NowFavInitial());
                  BlocProvider.of<FavoriteListBloc>(context)
                      .add(FavListingScreen());

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Removed from Favorites"),
                      behavior: SnackBarBehavior.floating,
                      duration: Duration(seconds: 2),
                    ),
                  );
                  setState(() {});
                },
                icon: favButtunSongList
                        .where((element) =>
                            element.favSongName ==
                            favButtonAllSongs[widget.index].songName)
                        .isEmpty
                    ? const Icon(Icons.favorite_border)
                    : const Icon(
                        Icons.favorite,
                        color: Colors.redAccent,
                      ),
              );
            },
          );
  }
}
