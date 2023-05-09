import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musi_city/application/recently_played/recently_played_bloc.dart';

import 'package:musi_city/functions/functions.dart';

import 'package:musi_city/mostly_played/mostly_playedscreen.dart';
import 'package:musi_city/my_playlists/my_playlistscreen.dart';
import 'package:musi_city/recently_played/recently_playedscreen.dart';

class PlaylistScreen extends StatefulWidget {
  const PlaylistScreen({super.key});

  @override
  State<PlaylistScreen> createState() => _PlaylistScreenState();
}

class _PlaylistScreenState extends State<PlaylistScreen> {
  @override
  Widget build(BuildContext context) {
    final mqheight = MediaQuery.of(context).size.height;
    final mqwidth = MediaQuery.of(context).size.width;

    return Scaffold(
      // backgroundColor: musiCityBgColor,

      body: Column(
        children: [
          Padding(
            padding:
                EdgeInsets.fromLTRB(mqwidth * 0.005, mqheight * 0.05, 0, 0),
            child: Container(
              height: mqheight * 0.1,
              width: mqwidth * 0.8,
              decoration: const BoxDecoration(
                //  color: Colors.amber,
                image: DecorationImage(
                  image: AssetImage('assets/playlist.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) =>  MostlyPlayedScreen(),
              ));
            },
            child: ListTile(
              title: Text(
                "Mostly Played",
                style: songNameStyle,
              ),
              trailing: rightArrow(),
            ),
          ),
          InkWell(
            onTap: () {
              // BlocProvider.of<RecentlyPlayedBloc>(context)
              //     .add(RecentShowListEvent());
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => RecentlyPlayedScreen(),
                ),
              );
              // List<RecentlyModel> recentLog = recentlyPlayedBox.values.toList();
              // for (var i = 0; i < recentLog.length; i++) {
              //   log(recentLog[i].recentSongName);
              // }
            },
            child: ListTile(
              title: Text(
                "Recently Played",
                style: songNameStyle,
              ),
              trailing: rightArrow(),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const MyPlaylist(),
              ));
            },
            child: ListTile(
              title: Text(
                "Playlist's",
                style: songNameStyle,
              ),
              trailing: rightArrow(),
            ),
          ),
        ],
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
