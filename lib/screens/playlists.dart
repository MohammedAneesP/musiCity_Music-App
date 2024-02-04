import 'package:flutter/material.dart';
import 'package:musi_city/functions/functions.dart';
import 'package:musi_city/screens/mostly_played/mostly_playedscreen.dart';
import 'package:musi_city/screens/my_playlists/my_playlistscreen.dart';
import 'package:musi_city/screens/recently_played/recently_playedscreen.dart';

class PlaylistScreen extends StatelessWidget {
  const PlaylistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Playlists",
          style: headingStyle,
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => MostlyPlayedScreen(),
                ));
              },
              child: ListTile(
                title: const Text(
                  "Mostly Played",
                  style: songNameStyle,
                ),
                trailing: rightArrow(),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => RecentlyPlayedScreen(),
                  ),
                );
              },
              child: ListTile(
                title: const Text(
                  "Recently Played",
                  style: songNameStyle,
                ),
                trailing: rightArrow(),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => MyPlaylist(),
                ));
              },
              child: ListTile(
                title: const Text(
                  "Playlist's",
                  style: songNameStyle,
                ),
                trailing: rightArrow(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget rightArrow() {
  return const Icon(
    Icons.chevron_right_sharp,
    //color: Colors.white,
  );
}
