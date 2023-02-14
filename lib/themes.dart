import 'package:flutter/material.dart';

const Color lightDisabledColor = Color(0xFF3B3B3B), darkDisabledColor = Color(0xFFADADAD);

ThemeData lightTheme = ThemeData(
  fontFamily: "Poppins",
  scaffoldBackgroundColor: Colors.white,
  disabledColor: lightDisabledColor,
  cardColor: Colors.grey[200]!,
  textTheme: const TextTheme(
    titleLarge: TextStyle(
      color: Colors.black,
      fontSize: 28.0,
      fontWeight: FontWeight.w500,
      height: 1.0,
    ),
    headlineSmall: TextStyle(
      color: Colors.black,
      fontSize: 16.0,
    ),
    headlineMedium: TextStyle(
      color: lightDisabledColor,
      fontSize: 16.0,
      fontWeight: FontWeight.w600,
    ),
    bodyLarge: TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.w600,
      color: Colors.black,
    ),
    bodyMedium: TextStyle(
      fontSize: 14.0,
      color: Colors.black,
    ),
    bodySmall: TextStyle(
      fontSize: 12.0,
      color: Colors.black,
      fontStyle: FontStyle.italic,
    ),
  ),
  bottomSheetTheme: const BottomSheetThemeData(
    backgroundColor: Colors.white,
  ),
);

ThemeData darkTheme = ThemeData(
  fontFamily: "Poppins",
  scaffoldBackgroundColor: Colors.black,
  disabledColor: darkDisabledColor,
  cardColor: Colors.grey[900]!,
  textTheme: const TextTheme(
    titleLarge: TextStyle(
      color: Colors.white,
      fontSize: 28.0,
      fontWeight: FontWeight.w500,
      height: 1.0,
    ),
    headlineSmall: TextStyle(
      color: Colors.white,
      fontSize: 16.0,
    ),
    headlineMedium: TextStyle(
      color: darkDisabledColor,
      fontSize: 16.0,
      fontWeight: FontWeight.w600,
    ),
    bodyLarge: TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    ),
    bodyMedium: TextStyle(
      fontSize: 14.0,
      color: Colors.white,
    ),
    bodySmall: TextStyle(
      fontSize: 12.0,
      color: Colors.white,
      fontStyle: FontStyle.italic,
    ),
  ),
  bottomSheetTheme: BottomSheetThemeData(
    backgroundColor: Colors.grey[900]!,
  ),
);
