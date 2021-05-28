import 'package:flutter/material.dart';

import '../../../theme/theme.dart';

class DifficultySlider extends StatefulWidget {
  DifficultySlider({Key? key}) : super(key: key);

  @override
  _DifficultySliderState createState() => _DifficultySliderState();
}

class _DifficultySliderState extends State<DifficultySlider> {
  double _value = 1;

  @override
  Widget build(BuildContext context) {
    return SliderTheme(
      data: Theme.of(context).sliderTheme.copyWith(
          thumbShape: CustomSliderThumbRect(
            thumbHeight: 50,
            thumbRadius: kBaseFactor * 4,
          ),
          inactiveTrackColor: kCardDarkColor),
      child: Slider.adaptive(
          value: _value,
          min: 1,
          max: 3,
          divisions: 2,

          // label: _value.toInt().toString(),
          mouseCursor: MouseCursor.defer,
          onChanged: (double newValue) {
            setState(() {
              print(newValue);
              _value = newValue;
            });
          }),
    );
  }
}
