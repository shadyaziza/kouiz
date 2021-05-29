import 'package:flutter/material.dart';
import 'package:kouiz/categories/service/category_provider.dart';
import 'package:kouiz/common/common.dart';
import 'package:kouiz/load_quiz/model/quiz.dart';

import '../../../common/extensions/extensions.dart';
import '../../model/category.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({Key? key, required this.category}) : super(key: key);
  final Category category;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        final provider = context.read(quizSettingsProvider);
        final settings = provider.quizSettings;
        provider.setQuizSettings(
            settings.copyWith(level: null, limit: null, category: category));
        print(provider.toString());
        Navigator.of(context)
            .pushNamed(AppRouter.quizRoute, arguments: provider.quizSettings);
      },
      child: Card(
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
      ),
    );
  }
}
