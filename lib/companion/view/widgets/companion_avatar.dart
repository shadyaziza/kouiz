import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';

import '../../../common/common.dart';
import '../../../theme/theme.dart';

class CompanionAvatar extends StatelessWidget {
  const CompanionAvatar(
      {Key? key,
      required this.isSelected,
      required this.imagePath,
      required this.color})
      : super(key: key);
  final bool? isSelected;
  final String imagePath;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    print(isSelected);
    if (isSelected == null)
      return CircleAvatar(
        radius: Responsive.isDesktop(context) ? 72 : 40,
        backgroundColor: Colors.transparent,
        child: Image.asset(
          imagePath,
          fit: BoxFit.contain,
          // height: Responsive.isDesktop(context) ? 120 : 64,
        ),
      );
    return PlayAnimation<double>(
      tween: Tween<double>(begin: 1, end: isSelected! ? 1 : 0.4),
      duration: Duration(seconds: 1),
      builder: (_, __, value) {
        return Opacity(
          opacity: value,
          child: CircleAvatar(
            backgroundColor:
                isSelected! ? kAvatarBlueColor : Colors.transparent,
            radius: Responsive.isDesktop(context) ? 72 : 40,
            child: Image.asset(
              imagePath,
              fit: BoxFit.contain,
              // height: Responsive.isDesktop(context) ? 120 : 64,
            ),
          ),
        );
      },
    );
  }
}
