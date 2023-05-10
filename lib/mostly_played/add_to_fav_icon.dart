// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musi_city/application/fav_now_play_button/fav_now_play_button_bloc.dart';
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
  List<AllSong> forMostlyFavAdd = allSongList.values.toList();

  List<FavoriteModel> mostlyFavorite = [];

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<FavNowPlayButtonBloc>(context).add(NowFavInitial());
    });
    mostlyFavorite = favoriteSong.values.toList();
    return mostlyFavorite
            .where((element) =>
                element.favSongName == forMostlyFavAdd[widget.index].songName)
            .isEmpty
        ? BlocBuilder<FavNowPlayButtonBloc, FavNowPlayButtonState>(
            builder: (context, state) {
              return IconButton(
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
                  BlocProvider.of<FavNowPlayButtonBloc>(context)
                      .add(NowFavInitial());
                  setState(() {});
                  SnackAddDeleteMsg("Added to Favorite's", context);
                },
                icon: const Icon(
                  Icons.favorite_outline_sharp,
                ),
              );
            },
          )
        : BlocBuilder<FavNowPlayButtonBloc, FavNowPlayButtonState>(
            builder: (context, state) {
              return IconButton(
                onPressed: () async {
                  int curntFavMostPlySong = mostlyFavorite.indexWhere(
                      (element) =>
                          element.favSongId == forMostlyFavAdd[widget.index].id);
                  await favoriteSong.deleteAt(curntFavMostPlySong);
                  BlocProvider.of<FavNowPlayButtonBloc>(context)
                      .add(NowFavInitial());
                   setState(() {});

                  SnackAddDeleteMsg("removed from favorite's", context);
                },
                icon: Icon(
                  Icons.favorite_sharp,
                  color: Colors.redAccent[400],
                ),
              );
            },
          );
  }
}
