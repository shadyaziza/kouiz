import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'constants.dart';

class AppTheme {
  static final appGradient = LinearGradient(
    colors: [
      kPurplePrimaryColor,
      kPurpleSecondaryColor,
    ],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );
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
      ),
      disabledColor: kUnselectedColor,
      bottomAppBarTheme: BottomAppBarTheme(color: kUnselectedAnswerColor),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: kUnselectedAnswerColor,
        unselectedItemColor: kUnselectedColor,
      ),
      sliderTheme: SliderThemeData(
        activeTrackColor: kCardDarkColor,
        inactiveTrackColor: kUnselectedColor,
        trackShape: RoundedRectSliderTrackShape(),
        trackHeight: kBaseFactor * 2,
        thumbShape: CustomSliderThumbCircle(thumbRadius: kBaseFactor * 2),

        // thumbShape: RoundSliderThumbShape(enabledThumbRadius: 12.0),
        // thumbColor: Colors.redAccent,
        overlayColor: kPurpleSecondaryColor.withAlpha(32),
        overlayShape: RoundSliderOverlayShape(overlayRadius: 28.0),
        // tickMarkShape: RoundSliderTickMarkShape(),
        // activeTickMarkColor: Colors.red[700],
        // inactiveTickMarkColor: Colors.red[100],
        valueIndicatorShape: PaddleSliderValueIndicatorShape(),
        valueIndicatorColor: kCardDarkColor,
        showValueIndicator: ShowValueIndicator.always,
        thumbColor: kPurplePrimaryColor,
        activeTickMarkColor: kWhiteColor, inactiveTickMarkColor: kWhiteColor,
        valueIndicatorTextStyle: TextStyle(
          color: kWhiteColor,
        ),
      ));
}

class CustomSliderThumbCircle extends SliderComponentShape {
  final double thumbRadius;
  final int min;
  final int max;

  const CustomSliderThumbCircle({
    required this.thumbRadius,
    this.min = 0,
    this.max = 10,
  });

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size.fromRadius(thumbRadius);
  }

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    Animation<double>? activationAnimation,
    Animation<double>? enableAnimation,
    bool? isDiscrete,
    TextPainter? labelPainter,
    RenderBox? parentBox,
    SliderThemeData? sliderTheme,
    TextDirection? textDirection,
    double? value,
    double? textScaleFactor,
    Size? sizeWithOverflow,
  }) {
    final Canvas canvas = context.canvas;

    final paint = Paint()
      ..color = kWhiteColor //Thumb Background Color
      ..style = PaintingStyle.fill;

    TextSpan span = new TextSpan(
      style: new TextStyle(
        fontSize: thumbRadius * .8,
        fontWeight: FontWeight.w700,
        color: kBackgroundColor, //Text Color of Value on Thumb
      ),
      text: getValue(value!),
    );

    TextPainter tp = new TextPainter(
        text: span,
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr);
    tp.layout();
    Offset textCenter =
        Offset(center.dx - (tp.width / 2), center.dy - (tp.height / 2));

    canvas.drawCircle(center, thumbRadius * .9, paint);
    tp.paint(canvas, textCenter);
  }

  String getValue(double value) {
    return (min + (max - min) * value).toInt().toString();
  }
}

class CustomSliderThumbRect extends SliderComponentShape {
  final double thumbRadius;
  final thumbHeight;
  final double min;
  final double max;

  const CustomSliderThumbRect(
      {required this.thumbRadius,
      required this.thumbHeight,
      this.min = 1,
      this.max = 3});

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size.fromRadius(thumbRadius);
  }

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    Animation<double>? activationAnimation,
    Animation<double>? enableAnimation,
    bool? isDiscrete,
    TextPainter? labelPainter,
    RenderBox? parentBox,
    SliderThemeData? sliderTheme,
    TextDirection? textDirection,
    double? value,
    double? textScaleFactor,
    Size? sizeWithOverflow,
  }) {
    final Canvas canvas = context.canvas;

    final rRect = RRect.fromRectAndRadius(
      Rect.fromCenter(
          center: center, width: thumbHeight * 1.4, height: thumbHeight * .6),
      Radius.circular(thumbRadius * .4),
    );

    final paint = Paint()
      ..color = kWhiteColor //Thumb Background Color
      ..style = PaintingStyle.fill;

    TextSpan span = new TextSpan(
        style: new TextStyle(
            fontSize: thumbHeight * .3,
            fontWeight: FontWeight.w700,
            color: kBackgroundColor,
            height: 1),
        text: getValue(value!));
    TextPainter tp = new TextPainter(
        text: span,
        textAlign: TextAlign.left,
        textDirection: TextDirection.ltr);
    tp.layout();
    Offset textCenter =
        Offset(center.dx - (tp.width / 2), center.dy - (tp.height / 2));

    canvas.drawRRect(rRect, paint);
    tp.paint(canvas, textCenter);
  }

  String getValue(double value) {
    // return value.toString();
    // // if (value >= 1.0) {
    // //   return 'Easy';
    // // } else if (value >= 2.0) {
    // //   return 'Medium';
    // // } else if (value >= 3.0) {
    // //   return 'Hard';
    // // } else {
    // //   return '';
    // // }
    //**todo figure why this does this */
    switch (value.toString()) {
      case '0.0':
        return 'Easy';
      case '0.5':
        return 'Medium';
      case '1.0':
        return 'Hard';
      default:
        return '';
    }
  }
}
