import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../common/common.dart';
import '../../common/view/widgets/gradient_button.dart';
import '../../theme/theme.dart';
// import 'package:velocity_x/velocity_x.dart';

class OnboardingView extends StatelessWidget {
  const OnboardingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(
                flex: 4,
                child: Lottie.asset('assets/lotties/landing-developer.json',
                    height: 300)),
            Flexible(
              flex: 2,
              child: Text.rich(
                TextSpan(
                  text: "Test yor technical knowledge with ",
                  style: TextStyle(color: kWhiteColor),
                  children: [
                    TextSpan(
                      text: '\n Κουίζ ',
                      style: TextStyle(
                          color: Theme.of(context).primaryColorLight,
                          fontSize: 24),
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
                textScaleFactor: 1.2,
              ),
            ),
            Spacer(
              flex: 1,
            ),
            GradientButton(
                onPressed: () {
                  Navigator.of(context)
                      .pushNamed(AppRouter.companionSelectionRoute);
                  // context.vxNav.push(
                  //   Uri.parse(AppRouter.companionSelectionRoute),
                  // );
                },
                label: 'GET STARTED'),
          ],
        ),
      ),
    );
  }
}
