import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musi_city/application/search_list/search_list_bloc.dart';
import 'package:musi_city/functions/functions.dart';
import 'package:musi_city/screens/now_playing/nowplaying_screen.dart';
import 'package:on_audio_query/on_audio_query.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  // late List<AllSong> searchAllSong;
  final TextEditingController searchcontroller = TextEditingController();

  List<Audio> searchedSong = [];

  AssetsAudioPlayer searchAudioplyr = AssetsAudioPlayer.withId("0");

// late List<AllSong> searchListingSong = List.from(searchAllSong);
  @override
  void initState() {
    BlocProvider.of<SearchListBloc>(context).add(InitialListing());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
   // WidgetsBinding.instance.addPostFrameCallback((_) {});
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
                    // onTap: () {
                    //   FocusManager.instance.primaryFocus?.unfocus();
                    // },
                    onChanged: (value) {
                      BlocProvider.of<SearchListBloc>(context)
                          .add(SearchListingShowing(query: value));
                    },
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.fromLTRB(12, 15, 12, 8),
                      hintText: "Songs",
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            width: 3,
                            // color: Colors.black87,
                          ),
                          borderRadius: BorderRadius.circular(20)),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          width: 3,
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
                  size: 35,
                ),
              ],
            ),
            SizedBox(
              height: mqheight * .02,
            ),
            Expanded(
              child: SizedBox(
                child: BlocBuilder<SearchListBloc, SearchListState>(
                  builder: (context, state) {
                    if (state.searchStateSongs.isEmpty) {
                      return const Center(
                        child: Text(
                          "No Song Found",
                          style: TextStyle(color: Colors.black),
                        ),
                      );
                    } else if (state.isNull == true) {
                      return const Center(
                        child: Text(
                          "No Song Found",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 45,
                          ),
                        ),
                      );
                    } else if (state.filteringSong.isNotEmpty) {
                      return ListView.separated(
                          itemBuilder: (context, index) {
                            searchedSong.clear();
                            for (var element in state.filteringSong) {
                              searchedSong.add(
                                Audio.file(
                                  element.songurl.toString(),
                                  metas: Metas(
                                    title: element.songName,
                                    artist: element.artists,
                                    id: element.id.toString(),
                                  ),
                                ),
                              );
                            }
                            return ListTile(
                              onTap: () {
                                FocusScope.of(context).unfocus();
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
                                        currentPlayIndex: index),
                                  ),
                                );
                              },
                              leading: QueryArtworkWidget(
                                  id: state.filteringSong[index].id,
                                  type: ArtworkType.AUDIO,
                                  artworkFit: BoxFit.cover,
                                  artworkQuality: FilterQuality.high,
                                  artworkBorder: BorderRadius.circular(30),
                                  nullArtworkWidget: const CircleAvatar(
                                    radius: 25,
                                    backgroundImage:
                                        AssetImage('assets/_.jpeg'),
                                  )),
                              title: Text(
                                state.filteringSong[index].songName,
                                style: songNameStyle,
                                overflow: TextOverflow.ellipsis,
                              ),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return const Divider();
                          },
                          itemCount: state.filteringSong.length);
                    } else {
                      return ListView.separated(
                        itemBuilder: (context, index) {
                          for (var element in state.searchStateSongs) {
                            searchedSong.add(
                              Audio.file(
                                element.songurl.toString(),
                                metas: Metas(
                                  title: element.songName,
                                  artist: element.artists,
                                  id: element.id.toString(),
                                ),
                              ),
                            );
                          }
                          return ListTile(
                            onTap: () {
                              FocusScope.of(context).unfocus();
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
                                      currentPlayIndex: index),
                                ),
                              );
                            },
                            leading: QueryArtworkWidget(
                                id: state.searchStateSongs[index].id,
                                type: ArtworkType.AUDIO,
                                artworkFit: BoxFit.cover,
                                artworkQuality: FilterQuality.high,
                                artworkBorder: BorderRadius.circular(30),
                                nullArtworkWidget: const CircleAvatar(
                                  radius: 25,
                                  backgroundImage: AssetImage('assets/_.jpeg'),
                                )),
                            title: Text(
                              state.searchStateSongs[index].songName,
                              style: songNameStyle,
                              overflow: TextOverflow.ellipsis,
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return const Divider();
                        },
                        itemCount: state.searchStateSongs.length,
                      );
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
