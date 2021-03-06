import 'package:flutter/material.dart';
import 'package:kouiz/theme/theme.dart';

class AvatarColorList extends StatelessWidget {
  const AvatarColorList({Key? key}) : super(key: key);
  final List<Color> avatarColors = const [
    Colors.white,
    kAvatarBlueColor,
    kAvatarDarkColor,
    kAvatarLightColor,
    kAvatarOrangeColor,
    kAvatarTealColor,
    kAvatarYellowColor,
  ];
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ...avatarColors.map(
          (e) => InkWell(
            onTap: () {},
            customBorder: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(kBaseFactor * 10),
            ),
            child: CircleAvatar(
                maxRadius: 12,
                backgroundColor: e,
                child: e == Colors.white
                    ? Container(height: 2, color: Colors.red)
                    : null),
          ),
        ),
      ],
    );
  }
}
