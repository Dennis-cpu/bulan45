import 'package:flutter/material.dart';

class MovieDetailsThumbnail extends StatelessWidget {
  final String thumbnail;

  const MovieDetailsThumbnail({Key? key, required this.thumbnail}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              height: 170,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(thumbnail),
                      fit: BoxFit.cover)
              ),
            ),
            const Icon(Icons.play_circle_outline, size: 100,
              color: Colors.white,)
          ],
        ),
        Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [Color(0x00f5f5f5), Color(0xfff5f5f5)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter)
          ),
          height: 80,
        )


      ],
    );
  }
}