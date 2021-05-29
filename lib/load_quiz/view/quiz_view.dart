import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:im_stepper/stepper.dart';
import 'package:kouiz/categories/service/category_provider.dart';
import 'package:kouiz/common/common.dart';
import 'package:kouiz/common/connectivity/view/connectivity_widget.dart';
import 'package:kouiz/load_quiz/model/quiz.dart';
import 'package:kouiz/load_quiz/service/api_provider.dart';
import 'package:kouiz/theme/constants.dart';

class QuizView extends ConsumerWidget {
  const QuizView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final quiz = watch(quizFutureProvider);

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
            return ParticlesBackground(
              child: Scaffold(
                  backgroundColor: Colors.transparent,
                  appBar: AppBar(
                    title: Text('Live Quiz'),
                  ),
                  body: QuizFlow()),
            );
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
    final quiz = watch(quizFutureProvider).data!.value;

    final List<Question> questions = quiz.questions;
    final List<int> stepNumbers =
        questions.map((e) => questions.indexOf(e) + 1).toList();
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        NumberStepper(
            direction: Axis.horizontal,
            activeStepColor: Theme.of(context).primaryColorLight,
            enableStepTapping: true,
            numbers: stepNumbers,
            numberStyle: TextStyle(color: kWhiteColor),
            enableNextPreviousButtons: false,
            activeStepBorderColor: Colors.transparent,
            lineColor: Colors.transparent),
        Expanded(
          child: PageView.builder(
              itemCount: quiz.questions.length,
              itemBuilder: (_, index) {
                final question = quiz.questions[index];
                return QuestionPage(question: question);
              }),
        ),
      ],
    );
  }
}

class QuestionPage extends StatelessWidget {
  const QuestionPage({Key? key, required this.question}) : super(key: key);
  final Question question;
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: kBaseFactor * 3, vertical: kBaseFactor * 3),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(kBaseFactor * 2),
            child: Image.asset(
              'assets/imgs/quiz.png',
              fit: BoxFit.cover,
              height: 185,
            ),
          ),
        ),
        Column(
          children: [
            Padding(
              padding: EdgeInsets.all(kBaseFactor * 2),
              child: Text(
                question.question,
                textScaleFactor: 1.2,
                textAlign: TextAlign.center,
              ),
            ),
            ...question.answers.map(
              (e) => ListTileTheme(
                tileColor: kCardDarkColor,
                horizontalTitleGap: kBaseFactor * 2,
                textColor: Theme.of(context).disabledColor,
                iconColor: kWhiteColor,
                contentPadding: EdgeInsets.all(kBaseFactor),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(kBaseFactor * 2),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    // tileColor: kCardDarkColor,
                    title: Padding(
                      padding: const EdgeInsets.only(left: kBaseFactor * 3),
                      child: Text(e.answer),
                    ),

                    // trailing: Icon(Icons.check_circle),
                  ),
                ),
              ),
            ),
            Padding(
                padding: EdgeInsets.symmetric(vertical: kBaseFactor * 4),
                child: GradientButton(onPressed: () {}, label: 'NEXT')),
            //  Container(
            //       width: 350,
            //       color: Theme.of(context).cardTheme.color,
            //       padding: EdgeInsets.all(kBaseFactor * 2),
            //       margin: EdgeInsets.all(kBaseFactor),
            //       child: Row(
            //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //         children: [
            //           Flexible(
            //               child: Text(
            //             e.answer,
            //             textAlign: TextAlign.justify,
            //             textScaleFactor: .85,
            //           )),
            //           Icon(Icons.check)
            //         ],
            //       ),
            //     ))
          ],
        )
      ],
    );
  }
}
