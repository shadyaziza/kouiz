import 'package:flutter/material.dart';
import 'package:kouiz/theme/theme.dart';
import 'package:simple_animations/simple_animations.dart';

class GradientButton extends StatelessWidget {
  const GradientButton({Key? key, required this.onPressed, required this.label})
      : super(key: key);
  final VoidCallback? onPressed;
  final String label;
  @override
  Widget build(BuildContext context) {
    final bool isDisabled = onPressed == null;
    if (isDisabled) return Container();
    return PlayAnimation<double>(
      tween: Tween<double>(begin: 0, end: 1),
      duration: Duration(milliseconds: 800),
      builder: (_, __, value) {
        return Opacity(
          opacity: value,
          child: Material(
            borderRadius: BorderRadius.circular(kBaseFactor),
            elevation: .2,
            child: InkWell(
              borderRadius: BorderRadius.circular(kBaseFactor),
              onTap: onPressed,
              child: Container(
                alignment: Alignment.center,
                constraints:
                    BoxConstraints(minWidth: 275, maxWidth: 275, minHeight: 75),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(kBaseFactor),
                  gradient: LinearGradient(
                    colors: [
                      Theme.of(context).primaryColorDark,
                      Theme.of(context).primaryColorLight,
                    ],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                ),
                child: Text(
                  label,
                  style: TextStyle(color: kWhiteColor),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
