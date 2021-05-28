import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../theme/theme.dart';
import 'widgets.dart';

class CompanionList extends StatefulWidget {
  CompanionList({Key? key}) : super(key: key);

  @override
  _CompanionListState createState() => _CompanionListState();
}

class _CompanionListState extends State<CompanionList> {
  final List<String> avatarsPath =
      List.generate(8, (index) => 'assets/avatars/0${index + 1}.png');
  String? _selectedCompanion;
  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center,
      runSpacing: kBaseFactor,
      spacing: kBaseFactor,
      children: [
        ...avatarsPath.map(
          (e) => InkWell(
            customBorder: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(kBaseFactor * 10),
            ),
            onTap: () {
              setState(() {
                _selectedCompanion = e;
              });
            },
            child: CompanionAvatar(
              color: null,
              isSelected:
                  _selectedCompanion == null ? null : e == _selectedCompanion,
              imagePath: e,
            ),
          ),
        ),
      ],
    );
  }
}
