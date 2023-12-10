
import 'package:flutter/material.dart';

class PlaylistTitle extends StatelessWidget {
  const PlaylistTitle({
    super.key,
    required this.mqheight,
    required this.mqwidth,
  });

  final double mqheight;
  final double mqwidth;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: mqheight * 0.1,
      width: mqwidth * 0.8,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/myplaylist.png'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
