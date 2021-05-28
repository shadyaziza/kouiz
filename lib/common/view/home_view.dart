import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import '../../categories/view/choose_category_view.dart';
import '../../categories/view/view.dart';
import '../../theme/app_theme.dart';
import '../../theme/constants.dart';
import '../common.dart';

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
      body: ParticlesBackground(
          child: PageView(
        children: [
          ChooseCategoryView(),
        ],
      )),
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
