import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_launcher_icons/xml_templates.dart';
import 'package:musi_city/functions/box_opening.dart';
import 'package:musi_city/functions/functions.dart';
import 'package:musi_city/main.dart';
import 'package:musi_city/models/home_models.dart';
import 'package:musi_city/models/mostly_model.dart';
import 'package:musi_city/screens/bottom_nav.dart';
import 'package:on_audio_query/on_audio_query.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

final audioQuery = OnAudioQuery();

List<SongModel> fetchSongs = [];
List<SongModel> fullSongs = [];

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    requestStoragePermission();
    gotoHomeScreen(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blueGrey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 200,
            decoration: const BoxDecoration(
                image:
                    DecorationImage(image: AssetImage("assets/new_icon.png"))),
          ),
         const SizedBox(
            height: 15,
          ),
          const Text(
            "musiCity",
            style: TextStyle(
              fontSize: 35,
              fontWeight: FontWeight.w800,
              color: Colors.white,
              decoration: TextDecoration.none
            ),
          )
        ],
      ),
    );
  }

  requestStoragePermission() async {
    bool permissionStatus = await audioQuery.permissionsStatus();

    if (permissionStatus == false) {
      await audioQuery.permissionsRequest();

      fetchSongs = await audioQuery.querySongs();

      for (var songElement in fetchSongs) {
        if (songElement.fileExtension == "m4a" ||
            songElement.fileExtension == "mp3") {
          fullSongs.add(songElement);
        }
      }

      for (var element in fullSongs) {
        allSongList.add(
          AllSong(
            songName: element.title,
            artists: element.artist!,
            duration: element.duration!,
            songurl: element.uri!,
            id: element.id,
          ),
        );
      }
      for (var songElement in fullSongs) {
        mostlyPlayedBox.add(
          MostlyModel(
            mostlySongName: songElement.title,
            mostlyArtistName: songElement.artist!,
            mostlyDuration: songElement.duration!,
            mostlySongUrl: songElement.uri!,
            songCount: 0,
            mostlySongId: songElement.id,
          ),
        );
      }
    }
  }

  Future gotoHomeScreen(context) async {
    await Future.delayed(const Duration(seconds: 5));
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => const MusiBottomNav(),
      ),
    );
  }
}
