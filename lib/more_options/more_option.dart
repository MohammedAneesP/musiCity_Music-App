import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musi_city/application/bloc/theme_changer_bloc.dart';
import 'package:musi_city/functions/functions.dart';
import 'package:musi_city/more_options/privacypolicy.dart';
import 'package:musi_city/more_options/terms&conditions.dart';
import 'package:switcher_button/switcher_button.dart';

class MoreOPtionScreen extends StatelessWidget {
  MoreOPtionScreen({super.key});
  bool musicNotify = true;

  AssetsAudioPlayer moreAudioplayer = AssetsAudioPlayer.withId("0");
  @override
  Widget build(BuildContext context) {
    final mqheight = MediaQuery.of(context).size.height;
    final mqwidth = MediaQuery.of(context).size.width;

    return Scaffold(
      //  backgroundColor: musiCityBgColor,
      body: Column(
        children: [
          Row(
            children: [
              Padding(
                padding:
                    EdgeInsets.fromLTRB(mqwidth * .008, mqheight * .045, 0, 0),
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios_new_rounded,
                    size: 20,
                    //  color: Colors.white,
                  ),
                ),
              ),
              Padding(
                padding:
                    EdgeInsets.fromLTRB(mqwidth * .1, mqheight * .045, 0, 0),
                child: Text(
                  "More Options",
                  style: headingStyle,
                ),
              )
            ],
          ),
          SizedBox(
            height: mqheight * .03,
          ),
          SizedBox(
            height: mqheight * .5,
            child: Column(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const TermsAndConditions(),
                    ));
                  },
                  child: ListTile(
                    title: Text(
                      listOfOptiions[0],
                      style: songNameStyle,
                    ),
                    trailing: listOfOptionsIcons[1],
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const PrivacyAndPolicy(),
                    ));
                  },
                  child: ListTile(
                    title: Text(listOfOptiions[1], style: songNameStyle),
                    trailing: listOfOptionsIcons[1],
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: ListTile(
                    title: Text(listOfOptiions[2], style: songNameStyle),
                    trailing: SwitcherButton(
                      offColor: Colors.grey,
                      onColor: Colors.blue,
                      value: true,
                      onChange: (value) {
                        moreAudioplayer.showNotification == musicNotify;
                      },
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: ListTile(
                    title: Text(
                      "Theme Change",
                      style: songNameStyle,
                    ),
                    trailing: BlocBuilder<ThemeChangerBloc, ThemeChangerState>(
                      builder: (context, state) {
                        return SwitcherButton(
                          offColor: Colors.grey,
                          onColor: Colors.blue,
                          onChange: (value) {
                            if (value == true) {
                              BlocProvider.of<ThemeChangerBloc>(context)
                                  .add(IsDarkMode());
                            } else {
                              BlocProvider.of<ThemeChangerBloc>(context)
                                  .add(IsLightMode());
                            }
                          },
                        );
                      },
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    aboutPopUp(context);
                  },
                  child: ListTile(
                    title: Text(
                      listOfOptiions[3],
                      style: songNameStyle,
                    ),
                    trailing: listOfOptionsIcons[1],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: mqheight * 0.3,
          ),
          const Text("Version"),
          SizedBox(
            height: mqheight * 0.005,
          ),
          const Text(
            "1.0.0",
            style: TextStyle(fontSize: 12),
          )
        ],
      ),
    );
  }

  aboutPopUp(context) {
    showAboutDialog(
      context: context,
      applicationName: 'musiCity',
      applicationIcon: Image.asset(
        'assets/_.jpeg',
        height: 40,
        width: 40,
      ),
      applicationVersion: "1.0.0",
      children: [
        const Text(
            "musiCity is an offline music player app which allows use to hear music from their storage and also do functions like add to favorites , create playlists , recently played , mostly played etc."),
        heightGapSizedBox(context),
        const Text('''App developed by :

Mohammed Anees''')
      ],
    );
  }
}

List listOfOptiions = [
  "Terms and Conditions",
  "Privacy and Policy",
  "Notifications",
  "About",
];

List listOfOptionsIcons = [
  GestureDetector(
    onTap: () {},
    child: const Icon(
      Icons.chevron_right_rounded,
      // color: Colors.white,
    ),
  ),
  GestureDetector(
    onTap: () {},
    child: const Icon(
      Icons.chevron_right_rounded,
      // color: Colors.white,
    ),
  ),
  IconButton(
    onPressed: () {},
    icon: const Icon(
      Icons.toggle_off_outlined,
      // color: Colors.white,
    ),
  ),
  IconButton(
    onPressed: () {},
    icon: const Icon(
      Icons.toggle_off_outlined,
      // color: Colors.white,
    ),
  ),
  GestureDetector(
    onTap: () {},
    child: const Icon(
      Icons.chevron_right_rounded,
      // color: Colors.white,
    ),
  ),
];
