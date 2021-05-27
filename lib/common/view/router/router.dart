import 'package:flutter/material.dart';
import 'package:kouiz/companion/companion.dart';
import 'package:kouiz/main.dart';
import 'package:kouiz/onboarding/view/onboarding_view.dart';
import 'package:velocity_x/velocity_x.dart';

class AppRouter {
  static final String homeRoute = 'home';
  static final String companionSelectionRoute = 'companion-select';
  static final Map<String, Widget Function(BuildContext)> routes = {
    '/': (_) => OnboardingView(),
    homeRoute: (_) => HomePage(),
    companionSelectionRoute: (_) => CompanionSelectionView(),
  };
  // static final Map<Pattern, VxPageBuilder> routes = {
  //   '/': (_, __) => MaterialPage(
  //         child: OnboardingView(),
  //       ),
  //   homeRoute: (_, __) => MaterialPage(
  //         child: HomePage(),
  //       ),
  //   companionSelectionRoute: (_, __) => MaterialPage(
  //         child: CompanionSelectionView(),
  //       ),
  // };
}
