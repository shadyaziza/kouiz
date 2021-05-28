import 'package:flutter/material.dart';

import '../../../theme/theme.dart';

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
            thumbShape: CustomSliderThumbCircle(
                thumbRadius: kBaseFactor * 2, max: 50, min: 5),
          ),
      child: Slider.adaptive(
          value: _value,
          max: 50,
          min: 5,
          divisions: 50,
          label: '${_value.toInt()} Questions',
          mouseCursor: MouseCursor.defer,
          onChanged: (double newValue) {
            setState(() {
              _value = newValue;
            });
          }),
    );
  }
}
