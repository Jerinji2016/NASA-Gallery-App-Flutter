import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  fontFamily: "Poppins",
  scaffoldBackgroundColor: Colors.white,
  disabledColor: const Color(0xFF3B3B3B),
  cardColor: Colors.grey[200]!,
  textTheme: const TextTheme(
    titleLarge: TextStyle(
      color: Colors.black,
      fontSize: 28.0,
      fontWeight: FontWeight.w500,
      height: 1.0,
    ),
  ),
);

ThemeData darkTheme = ThemeData(
  fontFamily: "Poppins",
  scaffoldBackgroundColor: Colors.black,
  disabledColor: const Color(0xFFADADAD),
  cardColor: Colors.grey[900]!,
  textTheme: const TextTheme(
    titleLarge: TextStyle(
      color: Colors.white,
      fontSize: 28.0,
      fontWeight: FontWeight.w500,
      height: 1.0,
    ),
  ),
);
