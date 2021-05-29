import 'package:flutter/material.dart';
import 'package:kouiz/load_quiz/view/quiz_view.dart';

import '../../../companion/companion.dart';
import '../../../onboarding/view/onboarding_view.dart';
import '../../common.dart';

class AppRouter {
  static final String homeRoute = 'home';
  static final String companionSelectionRoute = 'companion-select';
  static final String quizRoute = 'quizt';
  static final Map<String, Widget Function(BuildContext)> routes = {
    '/': (_) => OnboardingView(),
    homeRoute: (_) => HomeView(),
    companionSelectionRoute: (_) => CompanionSelectionView(),
    quizRoute: (_) => QuizView()
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
