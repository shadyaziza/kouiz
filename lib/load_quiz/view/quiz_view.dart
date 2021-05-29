import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:im_stepper/stepper.dart';
import 'package:kouiz/categories/service/category_provider.dart';
import 'package:kouiz/common/common.dart';
import 'package:kouiz/common/connectivity/view/connectivity_widget.dart';
import 'package:kouiz/load_quiz/model/quiz.dart';
import 'package:kouiz/load_quiz/service/api_provider.dart';

class QuizView extends ConsumerWidget {
  const QuizView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final QuizSettings quizSettings =
        ModalRoute.of(context)!.settings.arguments! as QuizSettings;
    final quiz = watch(quizFutureProvider(quizSettings));

    return ConnectivityWidget(
      networkWidget: ParticlesBackground(
        child: quiz.when(
          loading: () => Scaffold(
            body: Center(child: LoadingIndicator()),
          ),
          error: (_, error) => Scaffold(
              body: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                Icon(
                  Icons.error,
                  color: Theme.of(context).disabledColor,
                  size: 72,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    'There has been an error getting the quiz',
                    style: TextStyle(color: Theme.of(context).disabledColor),
                  ),
                ),
              ])),
          data: (Quiz quiz) {
            return Scaffold(
                appBar: AppBar(
                  title: Text(
                      '${quizSettings.category?.name}//${quizSettings.limit}//${quizSettings.difficulty}'),
                ),
                body: QuizFlow());
          },
        ),
      ),
    );
  }
}

class QuizFlow extends ConsumerWidget {
  const QuizFlow({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final quiz = watch(quizProvider!);
    final Quiz _quiz = quiz!;
    final List<Question> questions = _quiz.questions;
    final List<int> stepNumbers =
        questions.map((e) => questions.indexOf(e)).toList();
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        NumberStepper(
          activeStep: 1,
          direction: Axis.horizontal,
          enableStepTapping: true,
          numbers: stepNumbers,
          enableNextPreviousButtons: false,
        ),
        Expanded(
          child: ListView.builder(
              itemCount: quiz.questions.length,
              itemBuilder: (_, index) {
                final question = quiz.questions[index];
                return ListTile(
                  title: Text(question.category),
                  subtitle: Text(question.difficulty),
                );
              }),
        ),
      ],
    );
  }
}
