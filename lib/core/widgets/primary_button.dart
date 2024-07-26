import 'package:flutter/material.dart';

class PrimaryButton extends StatefulWidget {

  final String label;
  final Function onPressed;

  const PrimaryButton(
      {required Key key,
        required this.onPressed,
        required this.label})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return PrimaryButtonState();
  }
}

class PrimaryButtonState extends State<PrimaryButton> {

  @override
  Widget build(BuildContext context) {

    return ElevatedButton(

      onPressed: () => widget.onPressed,
      style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue,
          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
          textStyle: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold)
      ),
      child: Text(widget.label),
    );


  }

}
