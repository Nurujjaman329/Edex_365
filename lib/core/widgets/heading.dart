import 'package:flutter/material.dart';

class Heading extends StatelessWidget {

  final String text;

  const Heading(
      {required Key key,
        required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Text(
      text,
      style: const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold
      )
    );

  }

}