import 'package:flutter/material.dart';

import '../../../common/extensions/extensions.dart';
import '../../model/category.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({Key? key, required this.category}) : super(key: key);
  final Category category;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Flexible(
            child: Image.asset(
              category.imagePath,
              height: 50,
            ),
          ),
          FittedBox(child: Text('${category.name.capitalize()} Quiz')),
        ],
      ),
    );
  }
}
