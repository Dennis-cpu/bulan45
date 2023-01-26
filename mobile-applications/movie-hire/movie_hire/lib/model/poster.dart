import 'package:flutter/material.dart';

class MoviePoster extends StatelessWidget {
  final String poster;

  const MoviePoster({Key? key, required this.poster}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var borderRadius = const BorderRadius.all(Radius.circular(10));
    return Card(

      child: ClipRRect(
        borderRadius: borderRadius,
        child: Container(
          width: MediaQuery.of(context).size.width / 4,
          height: 160,
          decoration: BoxDecoration(
              image: DecorationImage(image: NetworkImage(poster),
                  fit: BoxFit.cover)
          ),
        ),
      ),
    );
  }
}

class MovieDetailsExtraPosters extends StatelessWidget {
  final List<String> posters;

  const MovieDetailsExtraPosters({Key? key, required this.posters}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left:8.0),
          child: Text("More Movie Posters".toUpperCase(),
            style: const TextStyle(
                fontSize: 14,
                color: Colors.black26
            ),),
        ),
        Container(
          height: 170,
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: ListView.separated(
              scrollDirection: Axis.horizontal,
              separatorBuilder: (context, index) => const SizedBox(width: 8,),
              itemCount: posters.length,
              itemBuilder: (context, index) => ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                child: Container(
                  width: MediaQuery.of(context).size.width / 4,
                  height: 160,
                  decoration: BoxDecoration(
                      image: DecorationImage(image: NetworkImage(posters[index]),
                          fit: BoxFit.cover)
                  ),

                ),

              ) ),
        )

      ],
    );
  }
}