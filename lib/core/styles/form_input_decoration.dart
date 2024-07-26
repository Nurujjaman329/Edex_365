import 'package:flutter/material.dart';

InputDecoration formInputDecoration(String label, Icon? icon) {
  return InputDecoration(
    // Customize the appearance of the input field
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(4.0),
      borderSide: BorderSide(
        color: Colors.grey,
        width: 1.0,
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(4.0),
      borderSide: const BorderSide(
        color: Colors.blueAccent,
        width: 1.0,
      ),
    ),
    filled: true,
    fillColor: Colors.white,
    contentPadding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),

    // Customize the appearance of the label text
    labelText: label,
    labelStyle: const TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.bold,
      fontSize: 16.0,
    ),

    // Customize the appearance of the helper text
    /*helperText: 'Custom Helper Text',
    helperStyle: TextStyle(
      color: Colors.grey,
      fontSize: 14.0,
    ),*/

    // Customize the appearance of the error text
    /*errorText: 'Custom Error Text',
    errorStyle: TextStyle(
      color: Colors.red,
      fontSize: 14.0,
    ),*/

    // Customize the appearance of the prefix icon
    prefixIcon: icon,
    prefixIconConstraints: const BoxConstraints(minWidth: 40.0, minHeight: 40.0),
    prefixIconColor: Colors.blue,

    // Customize the appearance of the suffix icon
    /*suffixIcon: const Icon(Icons.clear),
    suffixIconConstraints: const BoxConstraints(minWidth: 40.0, minHeight: 40.0),
    suffixIconColor: Colors.red,*/
  );
}
