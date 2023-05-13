import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:musi_city/application/mostly_played/mostly_played_bloc.dart';
import 'package:musi_city/functions/box_opening.dart';
import 'package:musi_city/functions/functions.dart';
import 'package:musi_city/main.dart';
import 'package:musi_city/models/home_models.dart';
import 'package:musi_city/mostly_played/add_to_fav_icon.dart';
import 'package:musi_city/now_playing/nowplaying_screen.dart';
import 'package:on_audio_query/on_audio_query.dart';
import '../models/mostly_model.dart';

class MostlyPlayedScreen extends StatelessWidget {
  MostlyPlayedScreen({super.key});

  List<MostlyModel> mostlyScreenSongs = [];
  List<Audio> mostlyConvrtAudio = [];
  final AssetsAudioPlayer mosplyAudioPlyr = AssetsAudioPlayer.withId('0');
  // late List<AllSong> allsongMostly;
  List<AllSong> fullSongForMostly = allSongList.values.toList();
  List<MostlyModel> msPldSongList = mostlyPlayedBox.values.toList();

  // void initState() {
  //   //fullSongForMostly

  //   // log(msPldSongList.toString());

  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<MostlyPlayedBloc>(context).add(MostlyScreenShow());
    });

    final mqheight = MediaQuery.of(context).size.height;
    final mqwidth = MediaQuery.of(context).size.width;

    return Scaffold(
      //  backgroundColor: musiCityBgColor,
      body: Column(
        children: [
          SizedBox(
            height: mqheight * .05,
          ),
          SizedBox(
            height: mqheight * 0.1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  height: mqheight * 0.28,
                  width: mqwidth * 0.815,
                  decoration: const BoxDecoration(
                    //  color: Colors.amber,
                    image: DecorationImage(
                        image: AssetImage('assets/mostly.png'),
                        fit: BoxFit.cover),
                  ),
                ),
                SizedBox(
                  width: mqwidth * 0.06,
                ),
                IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title:
                              const Text("Do you want to clear all songs..?"),
                          content: const Text("Are you Sure..."),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text("Cancel"),
                            ),
                            TextButton(
                                onPressed: () {
                                  // mostlyScreenSongs.clear();
                                  // setState(() {});
                                  Navigator.pop(context);
                                },
                                child: const Text("Yes"))
                          ],
                        );
                      },
                    );
                  },
                  icon: const Icon(
                    Icons.delete,
                    // color: whiteColor,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: SizedBox(
              child: BlocBuilder<MostlyPlayedBloc, MostlyPlayedState>(
                builder: (context, state) {
                  for (var oneSong in state.mostltStateList) {
                    if (oneSong.songCount >= 3) {
                      mostlyScreenSongs.remove(oneSong);
                      mostlyScreenSongs.add(oneSong);
                    }
                    // log(oneSong.toString());
                  }
                  if (state.mostltStateList.isEmpty) {
                    return Center(
                      child: Text(
                        'Nothing Played yet',
                        style: defaultTextStyle,
                      ),
                    );
                  } else {
                    //   for (var items in state.mostltStateList) {
                    //   mostlyConvrtAudio.add(
                    //     Audio.file(
                    //       items.mostlySongUrl,
                    //       metas: Metas(
                    //         title: items.mostlySongName,
                    //         artist: items.mostlyArtistName,
                    //         id: items.mostlySongId.toString(),
                    //       ),
                    //     ),
                    //   );
                    // }

                    List<MostlyModel> mostlyRevListing =
                        mostlyScreenSongs.reversed.toList();
                    for (var element in mostlyRevListing) {
                      mostlyConvrtAudio.add(
                        Audio.file(
                          element.mostlySongUrl,
                          metas: Metas(
                            title: element.mostlySongName,
                            artist: element.mostlyArtistName,
                            id: element.mostlySongId.toString(),
                          ),
                        ),
                      );
                    }
                    return ListView.separated(
                      itemBuilder: (context, index) {
                        return ListTile(
                          onTap: () {
                            mosplyAudioPlyr.open(
                              Playlist(
                                audios: mostlyConvrtAudio,
                                startIndex: index,
                              ),
                              headPhoneStrategy:
                                  HeadPhoneStrategy.pauseOnUnplug,
                              loopMode: LoopMode.playlist,
                              showNotification: true,
                            );
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) {
                                  return NowPlayingScreeen(
                                    currentPlayIndex:
                                        fullSongForMostly.indexWhere(
                                      (element) =>
                                          element.songName ==
                                          mostlyRevListing[index]
                                              .mostlySongName,
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                          leading: QueryArtworkWidget(
                            id: mostlyRevListing[index].mostlySongId,
                            type: ArtworkType.AUDIO,
                            artworkFit: BoxFit.cover,
                            artworkQuality: FilterQuality.high,
                            quality: 100,
                            artworkBorder: BorderRadius.circular(30),
                            nullArtworkWidget: CircleAvatar(
                              radius: 25,
                              backgroundImage: AssetImage(leadingImage),
                            ),
                          ),
                          title: Text(
                            mostlyRevListing[index].mostlySongName,
                            style: songNameStyle,
                            overflow: TextOverflow.ellipsis,
                          ),
                          subtitle: Text(
                            mostlyRevListing[index].mostlyArtistName,
                            style: songNameStyle,
                            overflow: TextOverflow.ellipsis,
                          ),
                          trailing: AddToFAvIcon(
                            index: fullSongForMostly.indexWhere(
                              (element) =>
                                  element.songName ==
                                  mostlyRevListing[index].mostlySongName,
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) => const Divider(),
                      itemCount: mostlyRevListing.length,
                    );
                  }
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
