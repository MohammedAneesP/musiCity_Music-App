import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const musiCityBgColor = Color.fromARGB(255, 106, 17, 17);

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

final defaultTextStyle = GoogleFonts.biryani(fontSize: 30, color: whiteColor);
final headingStyle = GoogleFonts.seymourOne(fontSize: 25, color: whiteColor,fontWeight: FontWeight.w800);
final songNameStyle = GoogleFonts.rowdies(color: whiteColor);
String areYouSure = "Are you sure..?";
String yesText = "Yes";
String noText = "No";

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

dynamic whiteColor = Colors.white;
