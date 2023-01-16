import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:musi_city/functions/functions.dart';
import 'package:musi_city/functions/themechange/themebutton.dart';
import 'package:musi_city/moreOptions/privacypolicy.dart';
import 'package:musi_city/moreOptions/terms&conditions.dart';
import 'package:switcher_button/switcher_button.dart';

class MoreOPtionScreen extends StatefulWidget {
  const MoreOPtionScreen({super.key});

  @override
  State<MoreOPtionScreen> createState() => _MoreOPtionScreenState();
}

bool musicNotify = true;

class _MoreOPtionScreenState extends State<MoreOPtionScreen> {
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
                      builder: (context) => TermsAndConditions(),
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
                      builder: (context) => PrivacyAndPolicy(),
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
                      size: 35,
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
                      listOfOptiions[3],
                      style: songNameStyle,
                    ),
                    trailing: ChangeThemeButton(),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

List listOfOptiions = [
  "Terms and Conditions",
  "Privacy and Policy",
  "Notifications",
  "Select Theme",
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
