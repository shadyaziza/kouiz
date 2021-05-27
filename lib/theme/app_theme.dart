import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kouiz/theme/constants.dart';

class AppTheme {
  static final theme = ThemeData(
      fontFamily: GoogleFonts.varelaRound().fontFamily,
      textTheme:
          GoogleFonts.varelaRoundTextTheme().apply(bodyColor: kWhiteColor),
      primaryColorDark: kPurplePrimaryColor,
      primaryColorLight: kPurpleSecondaryColor,
      scaffoldBackgroundColor: kBackgroundColor,
      accentColor: kCardDarkColor,
      appBarTheme: AppBarTheme(
          foregroundColor: kWhiteColor,
          centerTitle: true,
          elevation: 0.0,
          backgroundColor: kBackgroundColor),
      cardTheme: CardTheme(
        color: kCardDarkColor,
        margin: EdgeInsets.all(kBaseFactor * 3),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(kBaseFactor),
        ),
      ));
}
