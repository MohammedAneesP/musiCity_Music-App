import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:musi_city/functions/themechange/themechanging.dart';
import 'package:musi_city/models/home_models.dart';
import 'package:musi_city/screens/splashscreen.dart';
import 'package:provider/provider.dart';
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
    return ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      builder: (context, child) {

        final themeProvider = Provider.of<ThemeProvider>(context);

        return  MaterialApp(
        title: "musiCity",
        
        themeMode: themeProvider.themeMode,
        theme: MyThemes.lightTheme,
        darkTheme: MyThemes.dakTheme,
        home: const SplashScreen(),
        debugShowCheckedModeBanner: false,
      );
      },
      
    );
  }
}
