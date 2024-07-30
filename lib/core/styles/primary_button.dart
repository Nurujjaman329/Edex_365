import 'package:flutter/material.dart';

import '../utils/app_colors.dart';

ButtonStyle primaryButton() {
  return ElevatedButton.styleFrom(
      backgroundColor:  AppColors.primaryColor,
      padding: const EdgeInsets.symmetric(horizontal: 120, vertical: 10),
      textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold));
}
