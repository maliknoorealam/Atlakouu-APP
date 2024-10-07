import 'package:atalakou/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyTheme{
  ThemeData myTheme = ThemeData(
    scaffoldBackgroundColor: whiteColor,
    useMaterial3: true,
    brightness: Brightness.light,
    primaryColor: goldColor,
    cardColor: navyColor,
    canvasColor: whiteColor,
    focusColor: navyColor,
    fontFamily: GoogleFonts.oregano().fontFamily,
    appBarTheme: AppBarTheme(
      backgroundColor: goldColor,
        titleTextStyle: TextStyle(
          fontFamily: GoogleFonts.oregano().fontFamily,
            fontWeight: FontWeight.w400,
            color: whiteColor,
            fontSize: 32),
      iconTheme: const IconThemeData(
        color: whiteColor,
        size: 24
      )
    ),
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: whiteColor
    ),
  );
}