import 'package:flutter/material.dart';

class MovieField extends StatelessWidget {
  final String field;
  final String value;

  const  MovieField({Key? key, required this.field, required this.value}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text("$field : ", style: const TextStyle(
            color: Colors.black38,
            fontSize: 12, fontWeight: FontWeight.w300
        ),),
        Expanded(
          child: Text(value, style: const TextStyle(
              color: Colors.black, fontSize: 12, fontWeight: FontWeight.w300
          ),),
        )
      ],
    );
  }
}