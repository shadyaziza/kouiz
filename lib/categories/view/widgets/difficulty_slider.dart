import 'package:flutter/material.dart';
import 'package:kouiz/categories/service/category_provider.dart';

import '../../../theme/theme.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DifficultySlider extends StatefulWidget {
  DifficultySlider({Key? key}) : super(key: key);

  @override
  _DifficultySliderState createState() => _DifficultySliderState();
}

class _DifficultySliderState extends State<DifficultySlider> {
  double _value = 2;

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
              _value = newValue;
              print('Do even value changes$_value');
            });
            final provider = context.read(quizSettingsProvider);
            final settings = provider.quizSettings;
            provider.setQuizSettings(settings.copyWith(
                category: null, level: _value.toInt(), limit: null));

            print(provider.toString());
            print(
                'just under provider diff equals ${provider.quizSettings.difficulty}');
          }),
    );
  }
}
