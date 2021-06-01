import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kouiz/load_quiz/model/quiz.dart';

final indexStateProvider = StateProvider.autoDispose<PageController>(
    (ref) => PageController(initialPage: 0));

final currentQuestion = ScopedProvider<Question>(null);

final quizSolvingProvider = StateProvider<QuizBloc>((ref) {
  return QuizBloc(quiz: null);
});

class QuizBloc extends StateNotifier {
  QuizBloc({required this.quiz}) : super(quiz);
  late Quiz? quiz;
  late Question currentQuestion;
  bool isCorrectlyAnswered = false;
  bool isAnswered = false;
  void setQuiz(Quiz quiz) {
    this.quiz = quiz;
  }

  void setCurrentQuestion(Question question) {
    currentQuestion = question;
  }
  // bool isQuestionAnswered(Question question)=>
  // void setQuestion(Question question) {
  //   this.question = question;
  // }

  // void checkAnswer(Answer answer) => answer.answer == question!.correctAnswer;
  // bool isQuestionAnswered = false;
  // void setIsQuestionAnswered() => isQuestionAnswered = true;
  late int score = 0;
  void _incrementScore() => score += 5;
  void _decrementScore() => score -= 5;
  void answerSelected(Answer answer) {
    if (answer.isCorrect) {
      _incrementScore();
    } else {
      _decrementScore();
    }
  }

  // bool isCorrectAnswer(String answer) {
  //   return answer == question!.correctAnswer;
  // }
}

// final quizScoreProvider =
//     Provider<int>((ref) => ref.watch(questionProvider).state.score);
