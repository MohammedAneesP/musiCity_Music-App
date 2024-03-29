import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
import 'package:readmore/readmore.dart';

const musiCityBgColor = Color.fromARGB(255, 113, 14, 14);
//dynamic whiteColor = Colors.white;

dynamic conatainerDecoration = BoxDecoration(
  borderRadius: BorderRadius.circular(45),
  gradient: const LinearGradient(colors: [
    Color.fromARGB(255, 137, 0, 0),
    Color.fromARGB(255, 157, 10, 10),
    Color.fromARGB(255, 157, 30, 30),
   Color.fromARGB(255, 157, 30, 30),
    Color.fromARGB(255, 157, 10, 10),
     Color.fromARGB(255, 137, 0, 0),
  ]),
  boxShadow: const [
    BoxShadow(
      offset: Offset.zero,
      blurRadius: 10,
      blurStyle: BlurStyle.outer,
    ),
  ],
);

const defaultTextStyle = TextStyle(fontSize: 25);
//  GoogleFonts.biryani(fontSize: 25, );
const headingStyle = TextStyle(fontSize: 25,fontWeight: FontWeight.w800);
//  GoogleFonts.seymourOne(fontSize: 25,fontWeight: FontWeight.w800);
const songNameStyle = TextStyle(fontStyle: FontStyle.italic);
// GoogleFonts.rowdies();
String areYouSure = "Are you sure..?";
String yesText = "Yes";
String noText = "No";

dynamic leadingImage = 'assets/new_icon.png';
dynamic nowPlayImage = 'assets/new_icon.png';

class SnackAddDeleteMsg {
  String snackAddDeleteText;
  SnackAddDeleteMsg(this.snackAddDeleteText, context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 3),
        content: Text(
          snackAddDeleteText,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}


Widget heightGapSizedBox(context) {
  final mqheight = MediaQuery.of(context).size.height;
  return SizedBox(
    height: mqheight * 0.02,
  );
}

Widget heightGapSizedBoxHeading(context) {
  final mqheight = MediaQuery.of(context).size.height;
  return SizedBox(
    height: mqheight * 0.05,
  );
}


Widget moreOptionHead(context, String screenHead) {
  final mqheight = MediaQuery.of(context).size.height;
  final mqwidth = MediaQuery.of(context).size.width;
  return SizedBox(
    height: mqheight * 0.05,
    child: Padding(
      padding: EdgeInsets.fromLTRB(mqwidth * 0.02, 0, 0, 0),
      child: Text(
        screenHead,
        style: headingStyle,
      ),
    ),
  );
}

Widget moreoptionParaText(context, String paratext) {
  final mqwidth = MediaQuery.of(context).size.width;

  return SizedBox(
    child: Padding(
      padding: EdgeInsets.fromLTRB(mqwidth * 0.03, 0, mqwidth * 0.03, 0),
      child: ReadMoreText(
        paratext,
        style: songNameStyle,
        textAlign: TextAlign.left,
        trimMode: TrimMode.Line,
        trimLines: 60,
      ),
    ),
  );
}


Widget moreOptinParaHead(context, String paraHead) {
  final mqwidth = MediaQuery.of(context).size.width;
  return Row(
    children: [
      Padding(
        padding: EdgeInsets.fromLTRB(mqwidth * 0.03, 0, mqwidth * 0.03, 0),
        child: Text(paraHead,
            style: const TextStyle(fontSize: 20, )),
      ),
    ],
  );
}