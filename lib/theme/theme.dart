import 'package:flutter/material.dart';

final defaultTheme = ThemeData(
    //colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
    useMaterial3: true,
    //scaffoldBackgroundColor: const Color.fromRGBO(255, 255, 255, 1.0),
    //scaffoldBackgroundColor: const Color.fromRGBO(43, 39, 39, 1.0),
    textTheme: TextTheme(
      bodyMedium: const TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w500),
      bodySmall: TextStyle(color: Colors.black.withOpacity(0.6), fontSize: 14),
    ),
    appBarTheme: const AppBarTheme(
        backgroundColor: Color.fromRGBO(43, 39, 39, 1.0),
        titleTextStyle:
        TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
        iconTheme: IconThemeData(color: Colors.white)),
    cardTheme: const CardTheme(
      color: Color.fromRGBO(30, 27, 27, 1),
    )
);