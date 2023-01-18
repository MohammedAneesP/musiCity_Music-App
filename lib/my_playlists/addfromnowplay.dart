import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:musi_city/functions/functions.dart';
import '../functions/box_opening.dart';
import '../main.dart';
import '../models/home_models.dart';
import '../models/playlist_model.dart';

// ignore: must_be_immutable
class AddFromNowPlay extends StatefulWidget {
  int songIndex;
  AddFromNowPlay({super.key, required this.songIndex});

  @override
  State<AddFromNowPlay> createState() => _AddFromNowPlayState();
}

class _AddFromNowPlayState extends State<AddFromNowPlay> {
  @override
  Widget build(BuildContext context) {
    final mqheight = MediaQuery.of(context).size.height;

    return IconButton(
      onPressed: () async {
        await showModalBottomSheet(
          context: context,
          builder: (context) {
            return SizedBox(
              height: mqheight * 0.4,
              //color: const Color.fromARGB(255, 45, 13, 13),
              child: Column(
                children: [
                  Text("My Playlist's", style: defaultTextStyle),
                  ValueListenableBuilder(
                    valueListenable: myPlaylist.listenable(),
                    builder:
                        (BuildContext, Box<PlaylistModel> addfromHomeplay, _) {
                      List<PlaylistModel> addPlaylistName =
                          addfromHomeplay.values.toList();
                      if (addPlaylistName.isEmpty) {
                        return Center(
                          child: Text(
                            "Playlist not created",
                            style: defaultTextStyle,
                          ),
                        );
                      } else {
                        return Expanded(
                          child: ListView.separated(
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {},
                                  child: ListTile(
                                    leading: const Icon(Icons.library_music_sharp,
                                       // color: whiteColor,
                                        ),
                                    title: Text(
                                      addPlaylistName[index].playlistName,
                                      style: songNameStyle,
                                    ),
                                    onTap: () {
                                      PlaylistModel? playSongName =
                                          myPlaylist.getAt(index);
                                      List<AllSong>? playlistSongdata =
                                          playSongName!.playlistSongs;
                                      List<AllSong> totalSongs =
                                          allSongList.values.toList();

                                      bool isAlreadyAdded =
                                          playlistSongdata.any((element) =>
                                              element.id ==
                                              totalSongs[widget.songIndex].id);
                                      if (isAlreadyAdded == false) {
                                        playlistSongdata.add(
                                          AllSong(
                                              songName:
                                                  totalSongs[widget.songIndex]
                                                      .songName,
                                              artists:
                                                  totalSongs[widget.songIndex]
                                                      .artists,
                                              duration:
                                                  totalSongs[widget.songIndex]
                                                      .duration,
                                              songurl:
                                                  totalSongs[widget.songIndex]
                                                      .songurl,
                                              id: totalSongs[widget.songIndex]
                                                  .id),
                                        );
                                        myPlaylist.putAt(
                                          index,
                                          PlaylistModel(
                                              playlistName:
                                                  addPlaylistName[index]
                                                      .playlistName,
                                              playlistSongs: playlistSongdata),
                                        );
                                        SnackAddDeleteMsg(
                                            "Added to playlist", context);
                                      } else {
                                        SnackAddDeleteMsg(
                                            "Already exist", context);
                                      }
                                      Navigator.pop(context);
                                    },
                                  ),
                                );
                              },
                              separatorBuilder: (context, index) {
                                return const Divider(
                                  thickness: 1,
                                 // color: whiteColor,
                                );
                              },
                              itemCount: myPlaylist.length),
                        );
                      }
                    },
                  ),
                ],
              ),
            );
          },
        );
        
      },
      icon: const Icon(
        Icons.add,
       // color: whiteColor,
        size: 30,
      ),
    );
  }
}
