import 'package:flutter/material.dart';
import 'package:musi_city/favorites/favorite_screen.dart';
import 'package:musi_city/functions/functions.dart';

import 'package:musi_city/screens/miniPlayer.dart';
import 'package:musi_city/screens/music_home.dart';
import 'package:musi_city/screens/playlists.dart';


class MusiBottomNav extends StatefulWidget {
  const MusiBottomNav({super.key});

  @override
  State<MusiBottomNav> createState() => _MusiBottomNavState();
}

class _MusiBottomNavState extends State<MusiBottomNav> {
  int currentSelect = 0;

  @override
  Widget build(BuildContext context) {
    List musiBottScreens = [
      const MusiHomeScreen(),
      const FavoritesScreen(),
      const PlaylistScreen(),
    ];

    return Scaffold(
      body: musiBottScreens[currentSelect],
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          labelTextStyle: MaterialStateProperty.all(
              const TextStyle(color: Colors.white70, fontSize: 13)),
          indicatorColor:const Color.fromARGB(255, 209, 136, 136),
        ),
        child: NavigationBar(
          selectedIndex: currentSelect,
          onDestinationSelected: (currentSelect) =>
              setState(() => this.currentSelect = currentSelect),
          height: 65,
          backgroundColor: musiCityBgColor,
          destinations: const [
            NavigationDestination(
                icon: Icon(
                  Icons.home,
                  color: Colors.white60,
                ),
                selectedIcon: Icon(Icons.home_outlined),
                label: "Home"),
            NavigationDestination(
                icon: Icon(
                  Icons.favorite,
                  color: Colors.white60,
                ),
                selectedIcon: Icon(Icons.favorite_border),
                label: "Favorites"),
            NavigationDestination(
              icon: Icon(
                Icons.playlist_add,
                color: Colors.white60,
              ),
              selectedIcon: Icon(Icons.playlist_add_circle_outlined),
              label: "Playlist",
            ),
          ],
        ),
      ),
      bottomSheet: const MiniPlayerBottom(),
    );
  }
}
