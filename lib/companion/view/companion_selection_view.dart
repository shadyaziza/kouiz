import 'package:flutter/material.dart';
// import 'package:kouiz/companion/view/widgets/avatar_color_list.dart';
import 'package:kouiz/theme/theme.dart';

import '../../common/view/view.dart';
import 'view.dart';

class CompanionSelectionView extends StatefulWidget {
  const CompanionSelectionView({Key? key}) : super(key: key);

  @override
  _CompanionSelectionViewState createState() => _CompanionSelectionViewState();
}

class _CompanionSelectionViewState extends State<CompanionSelectionView> {
  bool companionSelected = false;
  bool colorSelected = false;
  @override
  Widget build(BuildContext context) {
    return ParticlesBackground(
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            // actions: [
            //   IconButton(
            //     onPressed: () {
            //       setState(() {
            //         companionSelected = !companionSelected;
            //       });
            //     },
            //     icon: Icon(Icons.person),
            //   ),
            //   IconButton(
            //     onPressed: () {
            //       setState(() {
            //         colorSelected = !colorSelected;
            //       });
            //     },
            //     icon: Icon(Icons.color_lens),
            //   ),
            // ],
            title: Text('Companions'),
          ),
          body: Responsive(mobile: _MobileColumn(), desktop: _DesktopColumn()),
        ),
      ),
    );
  }
}

class _MobileColumn extends StatelessWidget {
  const _MobileColumn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text('Companions keep track of your score'),
        SizedBox(
          height: kBaseFactor,
        ),
        Flexible(
          flex: 4,
          child: CompanionList(),
        ),
        SizedBox(
          height: kBaseFactor * 2,
        ),

        // SizedBox(
        //   height: kBaseFactor / 4,
        // ),
        AvatarColorList(),

        Spacer(
          flex: 2,
        ),
        GradientButton(
            onPressed: () {
              Navigator.pushNamed(context, AppRouter.homeRoute);
            },
            label: 'NEXT')
      ],
    );
  }
}

class _DesktopColumn extends StatelessWidget {
  const _DesktopColumn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaxWidthContainer(
      child: Card(
          child: Padding(
        padding: const EdgeInsets.symmetric(vertical: kBaseFactor * 4),
        child: _MobileColumn(),
      )),
    );
  }
}
