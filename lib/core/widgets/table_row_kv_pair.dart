import 'package:flutter/material.dart';

TableRow tableRowKVPair(String field, String value) {
  return TableRow(children: [
    Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
          alignment: Alignment.centerLeft,
          child: Text(
            field,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
        )
      ],
    ),
    Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
          alignment: Alignment.centerRight,
          child: Text(
            value,
            style: const TextStyle(fontSize: 14),
            textAlign: TextAlign.end,
          ),
        )
      ],
    )
  ]);
}
