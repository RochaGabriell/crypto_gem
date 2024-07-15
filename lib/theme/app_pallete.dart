import 'package:flutter/material.dart';

class AppPallete {
  static const Color backgroundColor = Color.fromRGBO(255, 255, 255, 1);
  static const Color foregroundColor = Color.fromRGBO(23, 23, 26, 1);
  static const Color selectedColor = Color.fromRGBO(246, 84, 62, 1);
  static const Color disabledColor = Color.fromRGBO(157, 163, 183, 1);
  static const Gradient gradient = LinearGradient(
    colors: [Color(0xffff512f), Color(0xffdd2476)],
    stops: [0, 1],
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
  );
}
