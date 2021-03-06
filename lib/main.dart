import 'package:flutter/material.dart';
import 'package:kouiz/common/view/router/router.dart';
import 'package:kouiz/theme/theme.dart';

import 'package:url_strategy/url_strategy.dart';
import 'package:velocity_x/velocity_x.dart';

void main() {
  setPathUrlStrategy();
  runApp(Kouiz());
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

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('κουίζ'),
      ),
      body: Container(),
    );
  }
}
