import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_strategy/url_strategy.dart';

import 'common/view/router/router.dart';
import 'theme/theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setPathUrlStrategy();
  runApp(ProviderScope(child: Kouiz()));
}

class Kouiz extends StatelessWidget {
  const Kouiz({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // showPerformanceOverlay: true,
      // showSemanticsDebugger: true,
      routes: AppRouter.routes,
      theme: AppTheme.theme,
    );
    // return MaterialApp.router(
    //   debugShowCheckedModeBanner: false,
    //   // showPerformanceOverlay: true,
    //   // showSemanticsDebugger: true,
    //   routeInformationParser: VxInformationParser(),
    //   routerDelegate: VxNavigator(routes: AppRouter.routes),
    //   theme: AppTheme.theme,
    // );
  }
}
