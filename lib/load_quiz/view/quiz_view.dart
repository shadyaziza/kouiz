import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:kouiz/categories/service/category_provider.dart';
import 'package:kouiz/common/common.dart';
import 'package:kouiz/load_quiz/model/quiz.dart';
import 'package:kouiz/load_quiz/service/api_provider.dart';

class QuizView extends ConsumerWidget {
  const QuizView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final QuizSettings quizSettings =
        ModalRoute.of(context)!.settings.arguments! as QuizSettings;
    final quiz = watch(quizFutureProvider(quizSettings));

    return ParticlesBackground(
      child: quiz.when(
        loading: () => Scaffold(
          body: Center(
            child: SpinKitCubeGrid(
              itemBuilder: (_, int index) {
                return DecoratedBox(
                    decoration: BoxDecoration(
                        color: index.isEven
                            ? Theme.of(context).cardColor
                            : Theme.of(context).disabledColor));
              },
            ),
          ),
        ),
        error: (_, error) => Scaffold(
            body: Center(
          child: Text(
            error.toString(),
          ),
        )),
        data: (Quiz quiz) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                  '${quizSettings.category?.name}//${quizSettings.limit}//${quizSettings.difficulty}'),
            ),
            body: ListView.builder(
                itemCount: quiz.questions.length,
                itemBuilder: (_, index) {
                  final question = quiz.questions[index];
                  return ListTile(
                    title: Text(question.category),
                    subtitle: Text(question.difficulty),
                  );
                }),
          );
        },
      ),
    );
  }
}
