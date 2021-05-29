import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kouiz/load_quiz/model/quiz.dart';

import '../model/category.dart';

final categoryProvider = Provider<Set<Category>>(
  (ref) {
    return const {
      Category(name: 'javascript'),
      Category(name: 'linux'),
      Category(name: 'python'),
      Category(name: 'ansible'),
      Category(name: 'bash'),
      Category(name: 'docker'),
      Category(name: 'html'),
      Category(name: 'kubernetes'),
      Category(name: 'laravel'),
    };
  },
);
final quizSettingsProvider = Provider<QuizSettingsBloc>((ref) {
  //** setting category initally as null to enable quiz randomizer */
  return QuizSettingsBloc(QuizSettings(category: null));
});

class QuizSettingsBloc {
  QuizSettingsBloc(this.quizSettings);
  QuizSettings quizSettings;
  void setQuizSettings(QuizSettings settings) => quizSettings = settings;

  @override
  String toString() {
    return "QuizSettings {'category':${quizSettings.category?.name}'limit':${quizSettings.limit},'diff':${quizSettings.difficulty}  'lvl':${quizSettings.level}  }";
  }
}
