import 'package:flutter/material.dart';
import 'package:musi_city/functions/functions.dart';

class EmptyRecentlyPlayed extends StatelessWidget {
  const EmptyRecentlyPlayed({
    super.key,
    required this.mqheight,
    required this.mqwidth,
  });

  final double mqheight;
  final double mqwidth;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Recently Played",
          style: headingStyle,
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.delete,
            ),
          )
        ],
      ),
      body: const SafeArea(
        child: Center(
          child: Text(
            "Nothing Played Yet",
            style: defaultTextStyle,
          ),
        ),
      ),
    );
  }
}
