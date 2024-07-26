import 'package:flutter/material.dart';

class InfoTableCard extends StatelessWidget {
  final String text;
  final Widget table;

  const InfoTableCard({super.key, required this.text, required this.table});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        text.isNotEmpty
            ? Center(
                child: Text(
                  text,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              )
            : SizedBox(),
        text.isNotEmpty ? const SizedBox(height: 16) : SizedBox(),
        Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: ClipPath(
            //clipper: WaveClipper(),
            child: Container(
              //color: Color(0XFF1AA7EC),
              //decoration: BoxDecoration(
              //  borderRadius: BorderRadius.circular(10.0),
              //  image: DecorationImage(
              //    image: AssetImage('assets/images/back1.png'),
              //    fit: BoxFit.cover,
              //  ),
              //),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [table],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
