import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:kouiz/common/common.dart';
import 'package:kouiz/theme/app_theme.dart';
import 'package:kouiz/theme/constants.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavBar(),
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: Text('κουίζ'),
      ),
      body: ParticlesBackground(child: Container()),
    );
  }
}

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Container(
        height: 70,
        padding: const EdgeInsets.all(kBaseFactor),
        child: GNav(
          haptic: true, // haptic feedback
          tabBorderRadius: kBaseFactor / 2,
          tabBackgroundGradient: AppTheme.appGradient,
          // tab button shadow
          // curve: Curves.easeOutExpo, // tab animation curves
          duration: Duration(milliseconds: 900), // tab animation duration
          gap: kBaseFactor, // the tab button gap between icon and text
          color: Theme.of(context).disabledColor, // unselected icon color
          activeColor: kWhiteColor, // selected icon and text color
          // tab button icon size
          // selected tab background color
          padding: EdgeInsets.symmetric(
              horizontal: kBaseFactor,
              vertical: kBaseFactor), // navigation bar padding
          tabs: [
            GButton(
              // iconSize: 16,
              icon: Icons.quiz,
              text: 'Solve',
              textStyle: TextStyle(fontSize: 12),
            ),
            GButton(
              // iconSize: 16,
              icon: Icons.favorite,
              text: 'Likes',
              textStyle: TextStyle(fontSize: 12),
            ),
            GButton(
              // iconSize: 16,
              icon: Icons.notifications,
              text: 'Alerts',
              textStyle: TextStyle(fontSize: 12),
            ),
            GButton(
              // iconSize: 16,
              icon: Icons.person,
              text: 'Profile',
              textStyle: TextStyle(fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
