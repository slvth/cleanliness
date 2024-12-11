import 'package:flutter/material.dart';
//import 'package:google_fonts/google_fonts.dart';

final defaultTheme = ThemeData(
    //colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
    useMaterial3: true,
    //scaffoldBackgroundColor: const Color.fromRGBO(255, 255, 255, 1.0),
    //scaffoldBackgroundColor: const Color.fromRGBO(43, 39, 39, 1.0),
    scaffoldBackgroundColor: const Color.fromRGBO(230, 246, 241, 1.0),
    textTheme: TextTheme(
      bodyMedium: TextStyle(
          //fontFamily: GoogleFonts.lato().fontFamily,
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.w500),
      bodySmall: TextStyle(color: Colors.black.withOpacity(0.6), fontSize: 14),
    ),
    appBarTheme: const AppBarTheme(
        //backgroundColor: Color.fromRGBO(43, 39, 39, 1.0),
        backgroundColor: Color.fromRGBO(3, 142, 99, 1.0),
        titleTextStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
        iconTheme: IconThemeData(color: Colors.white)),
    cardTheme: const CardTheme(
      color: Color.fromRGBO(30, 27, 27, 1),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(double.infinity, 40),
        textStyle: const TextStyle(
            color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        foregroundColor: Colors.white, // text color
        backgroundColor: const Color.fromRGBO(10, 163, 115, 1),
      ),
    ));
