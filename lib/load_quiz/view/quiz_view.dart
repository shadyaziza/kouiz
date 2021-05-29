import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:im_stepper/stepper.dart';
import 'package:kouiz/categories/service/category_provider.dart';
import 'package:kouiz/common/common.dart';
import 'package:kouiz/common/connectivity/view/connectivity_widget.dart';
import 'package:kouiz/load_quiz/model/quiz.dart';
import 'package:kouiz/load_quiz/service/api_provider.dart';
import 'package:kouiz/load_quiz/service/ui_provider.dart';
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
  QuizFlow({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    ;
    final quiz = watch(quizFutureProvider).data!.value;

    final List<Question> questions = quiz.questions;
    final List<int> stepNumbers =
        questions.map((e) => questions.indexOf(e) + 1).toList();
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        QuiestionsStepper(stepNumbers: stepNumbers),
        Expanded(
          child: PageView.builder(
              controller: context.read(indexStateProvider).state,
              physics: NeverScrollableScrollPhysics(),
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

class QuiestionsStepper extends StatelessWidget {
  const QuiestionsStepper({
    Key? key,
    required this.stepNumbers,
  }) : super(key: key);

  final List<int> stepNumbers;

  @override
  Widget build(BuildContext context) {
    return NumberStepper(
        onStepReached: (int newIndex) {
          context.read(indexStateProvider).state.animateToPage(newIndex,
              duration: Duration(milliseconds: 450), curve: Curves.easeIn);
        },
        direction: Axis.horizontal,
        activeStepColor: Theme.of(context).primaryColorLight,
        enableStepTapping: true,
        numbers: stepNumbers,
        numberStyle: TextStyle(color: kWhiteColor),
        enableNextPreviousButtons: false,
        activeStepBorderColor: Colors.transparent,
        lineColor: Colors.transparent);
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
          child: QuestionBanner(),
        ),
        Column(
          children: [
            Padding(
              padding: EdgeInsets.all(kBaseFactor * 2),
              child: QuestionText(question: question),
            ),
            ...question.answers.map(
              (e) => AnswerWidget(answer: e),
            ),
            Padding(
                padding: EdgeInsets.symmetric(vertical: kBaseFactor * 4),
                child: GradientButton(onPressed: () {}, label: 'NEXT')),

            //     ))
          ],
        )
      ],
    );
  }
}

class AnswerWidget extends StatefulWidget {
  const AnswerWidget({Key? key, required this.answer}) : super(key: key);
  final Answer answer;

  @override
  _AnswerWidgetState createState() => _AnswerWidgetState();
}

class _AnswerWidgetState extends State<AnswerWidget> {
  bool isSelected = false;
  @override
  Widget build(BuildContext context) {
    return ListTileTheme(
      tileColor: isSelected && widget.answer.isCorrect
          ? kCorrectAnswerColor
          : isSelected && !widget.answer.isCorrect
              ? kErrorColor
              : kCardDarkColor,
      horizontalTitleGap: kBaseFactor * 2,
      textColor: isSelected ? kWhiteColor : Theme.of(context).disabledColor,
      iconColor: widget.answer.isCorrect ? kGreenColor : kWhiteColor,
      contentPadding: EdgeInsets.all(kBaseFactor),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(kBaseFactor * 2),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        // child:
        //  ProviderListener(
        //   provider: quizFutureProvider,
        //   onChange: (_, AsyncValue<Quiz> quiz) {
        //     final _quiz = quiz.data!.value;
        //     final bool isEqualToAnswer = _quiz.questions
        //         .any((q) => q.hashCode == widget.answer.hashCode);
        //     if (isEqualToAnswer) {
        //       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        //           content: Text(
        //               '${widget.answer.answer} is ${widget.answer.isCorrect}')));
        //     }
        //   },
        child: ListTile(
          onTap: () {
            print(widget.answer.toString());
            setState(() {
              isSelected = true;
            });
          },
          title: Padding(
            padding: const EdgeInsets.only(left: kBaseFactor * 3),
            child: Text(widget.answer.answer),
          ),
          trailing: isSelected && widget.answer.isCorrect
              ? Icon(Icons.check_circle)
              : isSelected && !widget.answer.isCorrect
                  ? Icon(Icons.close_rounded)
                  : null,
        ),
      ),
    );
  }
  // IconData? showIcon(){
  //   if (isSelected){
  //     if(widget.answer.isCorrect){
  //       return Icons.check_circle
  //     }
  //   }else{
  //     return null;
  //   }
  // }
}

class QuestionText extends StatelessWidget {
  const QuestionText({
    Key? key,
    required this.question,
  }) : super(key: key);

  final Question question;

  @override
  Widget build(BuildContext context) {
    return Text(
      question.question,
      textScaleFactor: 1.2,
      textAlign: TextAlign.center,
    );
  }
}

class QuestionBanner extends StatelessWidget {
  const QuestionBanner({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(kBaseFactor * 2),
      child: Image.asset(
        'assets/imgs/quiz.png',
        fit: BoxFit.cover,
        height: 185,
      ),
    );
  }
}
