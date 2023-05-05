import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:musi_city/application/bottom_nav/bottom_nav_bloc.dart';
import 'package:musi_city/application/music_home_screen/music_home_screen_bloc.dart';

import 'package:musi_city/models/home_models.dart';
import 'package:musi_city/screens/splashscreen.dart';

import 'application/favorite_list/favorite_list_bloc.dart';
import 'functions/box_opening.dart';
import 'models/favorite_model.dart';
import 'models/mostly_model.dart';
import 'models/playlist_model.dart';
import 'models/recently_model.dart';

late Box<AllSong> allSongList;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  Hive.registerAdapter(AllSongAdapter());
  allSongList = await Hive.openBox<AllSong>('listOfSongs');

  Hive.registerAdapter(RecentlyModelAdapter());
  openRecentlyModel();

  Hive.registerAdapter(FavoriteModelAdapter());
  openFavoriteModel();

  Hive.registerAdapter(PlaylistModelAdapter());
  openPLaylistModel();

  Hive.registerAdapter(MostlyModelAdapter());
  openMostlyPlayedModel();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => BottomNavBloc(),
        ),
        BlocProvider(
          create: (context) => MusicHomeScreenBloc(),
        ),
        BlocProvider(
          create: (context) => FavoriteListBloc(),
        )
      ],
      child: MaterialApp(
        theme: ThemeData(
          backgroundColor: Colors.black,
          scaffoldBackgroundColor: Colors.white,
          colorScheme: const ColorScheme.light(),
          primaryColor: Colors.white,
          iconTheme: const IconThemeData(
            color: Colors.black,
          ),
        ),
        title: "musiCity",
        home: const SplashScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
