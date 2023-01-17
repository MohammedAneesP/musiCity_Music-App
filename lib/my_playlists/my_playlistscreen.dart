import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:musi_city/functions/box_opening.dart';
import 'package:musi_city/functions/functions.dart';
import 'package:musi_city/models/playlist_model.dart';
import 'package:musi_city/my_playlists/createdplaylist.dart';

class MyPlaylist extends StatefulWidget {
  const MyPlaylist({super.key});

  @override
  State<MyPlaylist> createState() => _MyPlaylistState();
}

class _MyPlaylistState extends State<MyPlaylist> {
  TextEditingController playlistNameController = TextEditingController();

  TextEditingController playlistNameEditor = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final editorFormKey = GlobalKey<FormState>();

  List<PlaylistModel> listOfPlaylists = [];

  @override
  Widget build(BuildContext context) {
    final mqheight = MediaQuery.of(context).size.height;
    final mqwidth = MediaQuery.of(context).size.width;

    return Scaffold(
      floatingActionButton: Padding(
        padding: EdgeInsets.fromLTRB(0, 0, mqwidth * 0.05, mqheight * 0.03),
        child: FloatingActionButton(
         // backgroundColor: whiteColor,
          tooltip: "create playlist",
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text("Create Playlist"),
                  content: Form(
                    key: formKey,
                    child: TextFormField(
                      controller: playlistNameController,
                      decoration: const InputDecoration(
                        hintText: "enter name",
                      ),
                      validator: (value) {
                        List<PlaylistModel> playListDetails =
                            myPlaylist.values.toList();
                        bool isAlreadyThere = playListDetails
                            .where((element) =>
                                element.playlistName == value!.trim())
                            .isNotEmpty;

                        if (value!.trim().isEmpty) {
                          return "Name required";
                        }
                        if (isAlreadyThere) {
                          return "Existing Name";
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text("Cancel"),
                    ),
                    TextButton(
                      onPressed: () {
                        final isValid = formKey.currentState!.validate();
                        if (isValid) {
                          myPlaylist.add(
                            PlaylistModel(
                              playlistName: playlistNameController.text,
                              playlistSongs: [],
                            ),
                          );
                          SnackAddDeleteMsg("playlist created", context);
                          Navigator.pop(context);
                        }
                      },
                      child: const Text("Save"),
                    ),
                  ],
                );
              },
            );
          },
          child: const Icon(
            Icons.add,
            color: musiCityBgColor,
          ),
        ),
      ),
     // backgroundColor: musiCityBgColor,
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(0,mqheight*0.033, 0, 0),
            child: Container(
              height: mqheight * 0.1,
              width: mqwidth * 0.8,
              decoration: const BoxDecoration(
                 // color: Colors.amber,
                image: DecorationImage(
                  image: AssetImage('assets/myplaylist.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SizedBox(
            height: mqheight * 0.05,
          ),
          Expanded(
            child: SizedBox(
              child: ValueListenableBuilder(
                valueListenable: myPlaylist.listenable(),
                builder: (BuildContext, Box<PlaylistModel> playlistListing, _) {
                  List<PlaylistModel> playlistNameList =
                      playlistListing.values.toList();
                  if (playlistNameList.isEmpty) {
                    return Center(
                      child: Text(
                        "No Playlist Created yet",
                        style: defaultTextStyle,
                      ),
                    );
                  } else {
                    return ListView.separated(
                        itemBuilder: (context, index) {
                          PlaylistModel fullPlaylist = playlistNameList[index];
                          return ListTile(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return PlaylistCreated(
                                      allPlaylistSong:
                                          playlistNameList[index].playlistSongs,
                                      crntPlaylstName:
                                          playlistNameList[index].playlistName,
                                      playlistIndex: index,
                                    );
                                  },
                                ),
                              );
                            },
                            title: Text(
                              fullPlaylist.playlistName,
                              style: songNameStyle,
                            ),
                            trailing: PopupMenuButton(
                              icon: const Icon(
                                Icons.more_vert_sharp,
                                //color: whiteColor,
                              ),
                              color: Colors.red[100],
                              itemBuilder: (context) {
                                return [
                                  PopupMenuItem(
                                    value: 1,
                                    child: const Text("Delete"),
                                    onTap: () {
                                      OntapDelete(index, context);
                                    },
                                  ),
                                  PopupMenuItem(
                                    child: const Text("Edit"),
                                    onTap: () {
                                      playlistNameEditor =
                                          playlistNameController;
                                      Future.delayed(
                                        const Duration(seconds: 0),
                                        () => showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              title: const Text(
                                                "Rename Your Plalist",
                                              ),
                                              content: Form(
                                                key: editorFormKey,
                                                child: TextFormField(
                                                  controller:
                                                      playlistNameEditor,
                                                  decoration:
                                                      const InputDecoration(
                                                    border: OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: Colors.black),
                                                    ),
                                                  ),
                                                  validator: (value) {
                                                    List<PlaylistModel>
                                                        editValid = myPlaylist
                                                            .values
                                                            .toList();
                                                    bool isAlreadyThere = editValid
                                                        .where((element) =>
                                                            element
                                                                .playlistName ==
                                                            value!.trim())
                                                        .isNotEmpty;

                                                    if (value!.trim().isEmpty) {
                                                      return "Name required";
                                                    }
                                                    if (isAlreadyThere) {
                                                      return "Existing Name";
                                                    } else {
                                                      return null;
                                                    }
                                                  },
                                                ),
                                              ),
                                              actions: [
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: const Text("Cancel"),
                                                ),
                                                TextButton(
                                                  onPressed: () {
                                                    final isValid =
                                                        editorFormKey
                                                            .currentState!
                                                            .validate();
                                                    if (isValid) {
                                                      myPlaylist.putAt(
                                                        index,
                                                        PlaylistModel(
                                                          playlistName:
                                                              playlistNameEditor
                                                                  .text,
                                                          playlistSongs: [],
                                                        ),
                                                      );
                                                      Navigator.pop(context);
                                                    }
                                                  },
                                                  child: const Text("submit"),
                                                ),
                                              ],
                                            );
                                          },
                                        ),
                                      );
                                    },
                                  ),
                                ];
                              },
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return const Divider();
                        },
                        itemCount: playlistNameList.length);
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class OntapDelete {
  int index;
  OntapDelete(this.index, context) {
    Future.delayed(
      const Duration(seconds: 0),
      () => showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Do you want to Delete this playlist"),
            content: Text(areYouSure),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(noText),
              ),
              TextButton(
                onPressed: () {
                  myPlaylist.deleteAt(index);
                  Navigator.pop(context);
                  SnackAddDeleteMsg("Playlist removed", context);
                },
                child: Text(yesText),
              ),
            ],
          );
        },
      ),
    );
  }
}
