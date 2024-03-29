import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:musi_city/application/recently_played/recently_played_bloc.dart';
import 'package:musi_city/models/recently_model.dart';
import '../models/favorite_model.dart';
import '../models/mostly_model.dart';
import '../models/playlist_model.dart';

late Box<RecentlyModel> recentlyPlayedBox;
openRecentlyModel() async {
  recentlyPlayedBox = await Hive.openBox<RecentlyModel>('recentlyPlaySong');
}

updateRecentlyPlayed(RecentlyModel value, index,context) {
  List<RecentlyModel> updateRecent = recentlyPlayedBox.values.toList();
  bool isNotThere = updateRecent.where(
    (element) {
      return element.recentSongName == value.recentSongName;
    },
  ).isEmpty;
  if (isNotThere == true) {
    recentlyPlayedBox.add(value);
    BlocProvider.of<RecentlyPlayedBloc>(context).add(RecentShowListEvent());
  } else {
    int alreadyInIndex = updateRecent.indexWhere(
        (element) => element.recentSongName == value.recentSongName);
    recentlyPlayedBox.deleteAt(alreadyInIndex);
    recentlyPlayedBox.add(value);
     BlocProvider.of<RecentlyPlayedBloc>(context).add(RecentShowListEvent());
  }
  log(value.recentSongName);
}

//----------------------------------------------recentlySongs------------------------------------------------------//

late Box<FavoriteModel> favoriteSong;
openFavoriteModel() async {
  favoriteSong = await Hive.openBox("FavoriteSongList");
}

late Box<PlaylistModel> myPlaylist;
openPLaylistModel() async {
  myPlaylist = await Hive.openBox<PlaylistModel>("playlistNames");
}

late Box<MostlyModel> mostlyPlayedBox;
openMostlyPlayedModel() async {
  mostlyPlayedBox = await Hive.openBox<MostlyModel>('name');
}

updateMostlyPlayed(int songIndex, MostlyModel classObject) {
  int clickCount = classObject.songCount;

  classObject.songCount = clickCount + 1;
  mostlyPlayedBox.putAt(songIndex, classObject);
}
