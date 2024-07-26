import 'package:flutter/material.dart';

ButtonStyle primaryButton() {
  return ElevatedButton.styleFrom(
      backgroundColor: Colors.blue,
      padding: const EdgeInsets.symmetric(horizontal: 120, vertical: 10),
      textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold));
}
