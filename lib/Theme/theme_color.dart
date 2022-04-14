import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';

class themes{
  static final light= ThemeData(
    appBarTheme: AppBarTheme(backgroundColor: Colors.indigo),
    brightness: Brightness.light,
  );
  static final dark=ThemeData(
    appBarTheme: AppBarTheme(backgroundColor: Colors.black87),
    brightness: Brightness.dark
  );
}

TextStyle get subheading{
  return GoogleFonts.lato(
    fontSize: 18,
  );
}
TextStyle get heading{
  return GoogleFonts.lato(
      fontSize: 23,
    fontWeight: FontWeight.bold
  );
}
