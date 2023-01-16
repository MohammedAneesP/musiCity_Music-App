import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:musi_city/functions/functions.dart';
import 'package:musi_city/main.dart';
import 'package:musi_city/models/home_models.dart';
import 'package:musi_city/nowPlaying/nowplaying_screen.dart';
import 'package:on_audio_query/on_audio_query.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late List<AllSong> searchAllSong;
  final TextEditingController searchcontroller = TextEditingController();
  List<Audio> searchedSong = [];
  AssetsAudioPlayer searchAudioplyr = AssetsAudioPlayer.withId("0");

  @override
  void initState() {
    searchAllSong = allSongList.values.toList();
    for (var searchitem in searchListingSong) {
      searchedSong.add(
        Audio.file(
          searchitem.songurl,
          metas: Metas(
            title: searchitem.songName,
            artist: searchitem.artists,
            id: searchitem.id.toString(),
          ),
        ),
      );
    }

    super.initState();
  }

  late List<AllSong> searchListingSong = List.from(searchAllSong);

  @override
  Widget build(BuildContext context) {
    final mqheight = MediaQuery.of(context).size.height;
    final mqwidth = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
       //backgroundColor: musiCityBgColor,
        body: Column(
          children: [
            SizedBox(
              height: mqheight * .015,
            ),
            Row(
              children: [
                SizedBox(
                  width: mqwidth * .013,
                ),
                SizedBox(
                  height: mqheight * .06,
                  width: mqwidth * .85,
                  child: TextFormField(
                    controller: searchcontroller,

                    //-------------------------------------------------------search suggetion updating -----------------------------------------------//

                    onChanged: (value) {
                      return setState(
                        () {
                          searchListingSong = searchAllSong
                              .where(
                                (element) =>
                                    element.songName.toLowerCase().contains(
                                          value.toLowerCase(),
                                        ),
                              )
                              .toList();
                          searchedSong.clear();
                          for (var searchitem in searchListingSong) {
                            searchedSong.add(
                              Audio.file(
                                searchitem.songurl,
                                metas: Metas(
                                  title: searchitem.songName,
                                  artist: searchitem.artists,
                                  id: searchitem.id.toString(),
                                ),
                              ),
                            );
                          }
                        },
                      );

                      //----------------------------------------------------------search suggetion updating --------------------------------------------//
                    },
                    decoration: InputDecoration(
                      hintText: "Songs",
                      filled: true,
                    //  fillColor: Colors.white70,
                      //border: OutlineInputBorder(),
                      enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            width: 3,
                           // color: Colors.black87,
                          ),
                          borderRadius: BorderRadius.circular(20)),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          width: 3,
                         // color: Colors.black87,
                        ),
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: mqwidth * 0.02,
                ),
               const Icon(
                  Icons.search_rounded,
                  //color: whiteColor,
                  size: 35,
                ),
              ],
            ),
            SizedBox(
              height: mqheight * .02,
            ),
            Expanded(
              child: SizedBox(
                child: ListView.separated(
                    itemBuilder: (context, index) {
                      if (searchListingSong.isEmpty) {
                        return Center(
                          child: Text(
                            "No song Found",
                            style: defaultTextStyle,
                          ),
                        );
                      } else {
                        return ListTile(
                          onTap: () {
                            searchAudioplyr.open(
                              Playlist(
                                audios: searchedSong,
                                startIndex: index,
                              ),
                              showNotification: true,
                              loopMode: LoopMode.playlist,
                              headPhoneStrategy:
                                  HeadPhoneStrategy.pauseOnUnplug,
                            );
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => NowPlayingScreeen(
                                  currentPlayIndex: searchAllSong.indexWhere(
                                    (element) =>
                                        element.id ==
                                        searchListingSong[index].id,
                                  ),
                                ),
                              ),
                            );
                            FocusScope.of(context).unfocus();
                          },
                          leading: QueryArtworkWidget(
                              id: searchListingSong[index].id,
                              type: ArtworkType.AUDIO,
                              artworkFit: BoxFit.cover,
                              artworkQuality: FilterQuality.high,
                              artworkBorder: BorderRadius.circular(30),
                              nullArtworkWidget: const CircleAvatar(
                                radius: 25,
                                backgroundImage: AssetImage(
                                    'assets/pexels-sebastian-ervi-1763075.jpg'),
                              )),
                          title: Text(
                            searchListingSong[index].songName,
                            style: songNameStyle,
                            overflow: TextOverflow.ellipsis,
                          ),
                        );
                      }
                    },
                    separatorBuilder: (context, index) {
                      return const Divider(
                       // color: whiteColor,
                      );
                    },
                    itemCount: searchListingSong.length),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
