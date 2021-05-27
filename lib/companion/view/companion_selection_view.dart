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
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () {
                setState(() {
                  companionSelected = !companionSelected;
                });
              },
              icon: Icon(Icons.person),
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  colorSelected = !colorSelected;
                });
              },
              icon: Icon(Icons.color_lens),
            ),
          ],
          title: Text('Companions'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Companions keep track of your score'),
            SizedBox(
              height: kBaseFactor / 4,
            ),
            Flexible(
              flex: 12,
              child: CompanionList(),
            ),
            SizedBox(
              height: kBaseFactor * 2,
            ),
            Text('Select a Color'),
            SizedBox(
              height: kBaseFactor / 4,
            ),
            AvatarColorList(),
            Spacer(
              flex: 2,
            ),
            GradientButton(
                onPressed: companionSelected ? () {} : null, label: 'NEXT')
          ],
        ),
      ),
    );
  }
}
