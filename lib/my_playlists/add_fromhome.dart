// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:musi_city/functions/box_opening.dart';
import 'package:musi_city/functions/functions.dart';
import 'package:musi_city/main.dart';
import 'package:musi_city/models/home_models.dart';
import 'package:musi_city/models/playlist_model.dart';

class AddFromHomePlaylist extends StatefulWidget {
  int songIndex;
  AddFromHomePlaylist({super.key, required this.songIndex});

  @override
  State<AddFromHomePlaylist> createState() => _AddFromHomePlaylistState();
}

class _AddFromHomePlaylistState extends State<AddFromHomePlaylist> {
  @override
  Widget build(BuildContext context) {
    final mqheight = MediaQuery.of(context).size.height;
    // final mqwidth = MediaQuery.of(context).size.width;
    return TextButton(
      onPressed: () async {
        await showModalBottomSheet(
          context: context,
          builder: (context) {
            return SizedBox(
              height: mqheight * 0.4,
             // color: const Color.fromARGB(255, 45, 13, 13),
              child: ValueListenableBuilder(
                valueListenable: myPlaylist.listenable(),
                builder: (BuildContext, Box<PlaylistModel> addfromHomeplay, _) {
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
                    return Column(
                      children: [
                        SizedBox(
                          height: mqheight * 0.1,
                          child: Text("My Playlist's", style: defaultTextStyle),
                        ),
                        Expanded(
                          child: SizedBox(
                            child: ListView.separated(
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: () {},
                                    child: ListTile(
                                      leading: const Icon(Icons.library_music_sharp,
                                          //color: whiteColor,
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
                                                totalSongs[widget.songIndex]
                                                    .id);
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
                                          myPlaylist.put(
                                            index,
                                            PlaylistModel(
                                                playlistName:
                                                    addPlaylistName[index]
                                                        .playlistName,
                                                playlistSongs:
                                                    playlistSongdata),
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
                                   // color: whiteColor,
                                    indent: 20,
                                    endIndent: 20,
                                  );
                                },
                                itemCount: myPlaylist.length),
                          ),
                        ),
                      ],
                    );
                  }
                },
              ),
            );
          },
        );
        Navigator.pop(context);
      },
      child: Text(
        "Add to Playlist",
        style: songNameStyle,
      ),
    );
  }
}
