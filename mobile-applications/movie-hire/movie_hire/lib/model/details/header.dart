import 'package:flutter/material.dart';

import '../movie.dart';
class MovieDetailsHeader extends StatelessWidget {
  final Movie movie;

  const MovieDetailsHeader({Key? key, required this.movie}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text("${movie.year} . ${movie.genre}".toUpperCase(),
          style: const TextStyle(
              fontWeight: FontWeight.w400,
              color: Colors.cyan
          ),),
        Text(movie.title, style: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 32
        ),),
        Text.rich(TextSpan(style: const TextStyle(
          fontSize: 13, fontWeight: FontWeight.w300,
        ), children: <TextSpan> [
          TextSpan(
              text: movie.plot
          ),
          const TextSpan(
              text: "More...",
              style: TextStyle(
                  color: Colors.indigoAccent
              )
          )
        ]))
      ],
    );
  }
}