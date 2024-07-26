import 'package:flutter/material.dart';

class BoldText extends StatelessWidget {

  final String text;

  const BoldText(
      {required Key key,
        required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Text(
      text,
      style: const TextStyle(
        fontWeight: FontWeight.bold
      )
    );

  }

}
