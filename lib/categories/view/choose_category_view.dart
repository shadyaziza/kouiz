import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kouiz/common/connectivity/view/connectivity_widget.dart';

import '../service/category_provider.dart';
import 'view.dart';

class ChooseCategoryView extends ConsumerWidget {
  const ChooseCategoryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final list = watch(categoryProvider);

    return ConnectivityWidget(
      networkWidget: Column(
        children: [
          SizedBox(
            height: 12,
          ),
          QuestionsNumberSlider(),
          SizedBox(
            height: 12,
          ),
          DifficultySlider(),
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              children: [
                ...list.map(
                  (e) => CategoryCard(
                    category: e,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
