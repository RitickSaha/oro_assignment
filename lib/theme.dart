import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Dummy {
  static String lorem4 =
      "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s,";
  static String lorem2 =
      "Lorem Ipsum is simply dummy text of the printing and typesetting industry.";
  static String loremHead =
      "Lorem Ipsum";
}

class OroTheme {
  static TextStyle headTestStyle = GoogleFonts.nunitoSans(
    textStyle: TextTheme().headline4,
    fontSize: 24,
    color: Colors.black,
    fontWeight: FontWeight.w700,
    fontStyle: FontStyle.normal,
  );
  static TextStyle headTextStyle28 = GoogleFonts.nunitoSans(
    textStyle: TextTheme().headline4,
    fontSize: 28,
    color: Colors.black,
    fontWeight: FontWeight.w700,
    fontStyle: FontStyle.normal,
  );
  static TextStyle ctaTestStyle = GoogleFonts.nunitoSans(
    textStyle: TextTheme().headline4,
    fontSize: 18,
    color: Colors.black,
    fontWeight: FontWeight.w500,
    fontStyle: FontStyle.normal,
  );
  static TextStyle subHeadStyle = GoogleFonts.nunitoSans(
    textStyle: TextTheme().headline4,
    fontSize: 20,
    color: Colors.black,
    fontWeight: FontWeight.w700,
    fontStyle: FontStyle.normal,
  );
  static TextStyle visitTileAction = GoogleFonts.nunitoSans(
    textStyle: TextTheme().headline4,
    fontSize: 18,
    letterSpacing: 0.3,
    color: Color(0xFF16A085),
    fontWeight: FontWeight.w700,
    fontStyle: FontStyle.normal,
  );
  static TextStyle visitTileHead = GoogleFonts.nunitoSans(
    textStyle: TextTheme().headline4,
    fontSize: 18,
    letterSpacing: 0.3,
    color: Color(0xFF000000),
    fontWeight: FontWeight.w700,
    fontStyle: FontStyle.normal,
  );
  static TextStyle visitTileInfoHead = GoogleFonts.nunitoSans(
    textStyle: TextTheme().headline4,
    fontSize: 18,
    color: Color(0xFF4F4F4F),
    fontWeight: FontWeight.w700,
    fontStyle: FontStyle.normal,
  );
  static TextStyle tileInfoHead400 = GoogleFonts.nunitoSans(
    textStyle: TextTheme().headline4,
    fontSize: 18,
    color: Color(0xFF4F4F4F),
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.normal,
  );
  static TextStyle visitTileInfoSubHead = GoogleFonts.nunitoSans(
    textStyle: TextTheme().headline4,
    fontSize: 18,
    color: Color(0xFF6D6D6D),
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.normal,
  );
}
