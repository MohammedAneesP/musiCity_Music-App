
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
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: mqheight * 0.1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    height: mqheight * 0.29,
                    width: mqwidth * 0.83,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/recently.png'),
                          fit: BoxFit.cover),
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.delete,
                    ),
                  )
                ],
              ),
            ),
            const Spacer(),
            const Text(
              "Nothing Played Yet",
              style: headingStyle,
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
