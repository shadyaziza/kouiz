import 'package:flutter/material.dart';
import 'package:kouiz/common/common.dart';
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
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ...avatarColors.map(
          (e) => Padding(
            padding: const EdgeInsets.all(kBaseFactor),
            child: InkWell(
              onTap: () {},
              customBorder: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(kBaseFactor * 10),
              ),
              child: CircleAvatar(
                  maxRadius: Responsive.isDesktop(context) ? 24 : 16,
                  backgroundColor: e,
                  child: e == Colors.white
                      ? Container(height: 2, color: Colors.red)
                      : null),
            ),
          ),
        ),
      ],
    );
  }
}
