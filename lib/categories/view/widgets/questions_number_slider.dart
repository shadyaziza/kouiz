import 'package:flutter/material.dart';
import 'package:kouiz/categories/service/category_provider.dart';
import 'package:kouiz/load_quiz/model/quiz.dart';

import '../../../theme/theme.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class QuestionsNumberSlider extends StatefulWidget {
  QuestionsNumberSlider({Key? key}) : super(key: key);

  @override
  _QuestionsNumberSliderState createState() => _QuestionsNumberSliderState();
}

class _QuestionsNumberSliderState extends State<QuestionsNumberSlider> {
  double _value = 15;

  @override
  Widget build(BuildContext context) {
    return SliderTheme(
      data: Theme.of(context).sliderTheme.copyWith(
            thumbShape: CustomSliderThumbCircle(thumbRadius: kBaseFactor * 2),
          ),
      child: Slider.adaptive(
          value: _value,
          max: 20,
          min: 5,
          divisions: 20,
          label: '${_value.toInt()} Questions',
          mouseCursor: MouseCursor.defer,
          onChanged: (double newValue) {
            setState(() {
              _value = newValue;
            });
            final provider = context.read(quizSettingsProvider);
            final settings = provider.quizSettings;
            provider.setQuizSettings(settings.copyWith(
                category: null, limit: _value.toInt(), level: null));
          }),
    );
  }
}
