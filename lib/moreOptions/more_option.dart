import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:musi_city/functions/functions.dart';

class MoreOPtionScreen extends StatefulWidget {
  const MoreOPtionScreen({super.key});

  @override
  State<MoreOPtionScreen> createState() => _MoreOPtionScreenState();
}

class _MoreOPtionScreenState extends State<MoreOPtionScreen> {
  @override
  Widget build(BuildContext context) {
    final mqheight = MediaQuery.of(context).size.height;
    final mqwidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: musiCityBgColor,
      body: Column(
        children: [
          Row(
            children: [
              Padding(
                padding:
                    EdgeInsets.fromLTRB(mqwidth * .04, mqheight * .045, 0, 0),
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back_rounded,
                    size: 25,
                    color: Colors.white,
                  ),
                ),
              ),
              Padding(
                padding:
                    EdgeInsets.fromLTRB(mqwidth * .15, mqheight * .045, 0, 0),
                child: Text(
                  "More Options",
                  style:
                      GoogleFonts.montserrat(color: Colors.white, fontSize: 24),
                ),
              )
            ],
          ),
          SizedBox(
            height: mqheight * .03,
          ),
          SizedBox(
            height: mqheight * .5,
            child: ListView.separated(
                scrollDirection: Axis.vertical,
                itemBuilder: ((context, index) {
                  return InkWell(
                    onTap: (){},
                    child: ListTile(
                      title: Text(
                        listOfOptiions[index],
                        style: const TextStyle(color: Colors.white),
                      ),
                      trailing: listOfOptionsIcons[index],
                    ),
                  );
                }),
                separatorBuilder: ((context, index) {
                  return const Divider(
                    color: Colors.transparent,
                  );
                }),
                itemCount: listOfOptiions.length),
          ),
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
      color: Colors.white,
    ),
  ),
  GestureDetector(
    onTap: () {},
    child: const Icon(
      Icons.chevron_right_rounded,
      color: Colors.white,
    ),
  ),
  IconButton(
    onPressed: () {},
    icon: const Icon(
      Icons.toggle_off_outlined,
      color: Colors.white,
    ),
  ),
  IconButton(
    onPressed: () {},
    icon: const Icon(
      Icons.toggle_off_outlined,
      color: Colors.white,
    ),
  ),
  GestureDetector(
    onTap: () {},
    child: const Icon(
      Icons.chevron_right_rounded,
      color: Colors.white,
    ),
  ),
];
