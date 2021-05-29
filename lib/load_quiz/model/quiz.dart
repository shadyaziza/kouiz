import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:kouiz/categories/model/category.dart';

class QuizSettings {
  //**Level and difficulty because the slider returns double values while the api takes difficulty as string `Easy` `Medium` `Hard` */
  final int? level;
  String difficulty;

  final int limit;
  final Category? category;

  QuizSettings({int? level, int? limit, required this.category})
      : this.level = level ?? 2,
        this.difficulty = level == 1
            ? 'Easy'
            : level == 2
                ? 'Medium'
                : level == 3
                    ? 'Hard'
                    : 'Medium',
        this.limit = limit ?? 15;
  QuizSettings copyWith({
    int? level,
    int? limit,
    Category? category,
    // String? difficulty
  }) {
    print('from QuizSettings copyWith $level and $difficulty');
    return QuizSettings(
        category: category ?? this.category,
        limit: limit ?? this.limit,
        level: level ?? this.level)
      ..setDifficulty(checkDifficulty(level));
  }

  void setDifficulty(String? diff) {
    difficulty = diff ?? this.difficulty;
  }

  String? checkDifficulty(int? level) {
    switch (level) {
      case 1:
        print('from copywith: EASY');
        return 'Easy';

      case 2:
        print('from copywith: Medium');
        return 'Medium';

      case 3:
        print('from copywith: Hard');
        return 'Hard';

      default:
        print('from copywith: Null');
        return null;
    }
  }

  Map<String, String> toMap({required bool retry}) {
    return retry
        ? {
            'tag': category?.name ?? 'Linux',
            'difficulty': difficulty,
            'limit': limit.toString(),
          }
        : {
            'category': category?.name ?? 'Linux',
            'difficulty': difficulty,
            'limit': limit.toString(),
          };
  }
}

class Quiz extends Equatable {
  final List<Question> questions;
  Quiz({
    required this.questions,
  });

  Quiz copyWith({
    List<Question>? questions,
  }) {
    return Quiz(
      questions: questions ?? this.questions,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'questions': questions.map((x) => x.toMap()).toList(),
    };
  }

  factory Quiz.fromMap(List list) {
    // final List list = jsonDecode(d) as List;
    return Quiz(
      questions: List<Question>.from(list.map((x) => Question.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory Quiz.fromJson(String source) => Quiz.fromMap(json.decode(source));

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [questions];
}

class Question extends Equatable {
  final int id;
  final String question;
  // final Description description;
  final List<Answer> answers;
  //!! Returns a bool !//
  final bool multipleCorrectAnswers;

  //!! Returns the only correct answer and null otherwise//
  final String? correctAnswer;
  // final Explanation explanation;
  // final Tip tip;
  final List<Tag> tags;
  final String category;
  final String difficulty;
  Question({
    required this.id,
    required this.question,
    required this.answers,
    required this.multipleCorrectAnswers,
    required this.correctAnswer,
    required this.tags,
    required this.category,
    required this.difficulty,
  });

  Question copyWith({
    int? id,
    String? question,
    List<Answer>? answers,
    bool? multipleCorrectAnswers,
    String? correctAnswer,
    List<Tag>? tags,
    String? category,
    String? difficulty,
  }) {
    return Question(
      id: id ?? this.id,
      question: question ?? this.question,
      answers: answers ?? this.answers,
      multipleCorrectAnswers:
          multipleCorrectAnswers ?? this.multipleCorrectAnswers,
      correctAnswer: correctAnswer ?? this.correctAnswer,
      tags: tags ?? this.tags,
      category: category ?? this.category,
      difficulty: difficulty ?? this.difficulty,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'question': question,
      'answers': answers.map((x) => x.toMap()).toList(),
      'multipleCorrectAnswers': multipleCorrectAnswers,
      'correctAnswer': correctAnswer,
      'tags': tags.map((x) => x.toMap()).toList(),
      'category': category,
      'difficulty': difficulty,
    };
  }

  factory Question.fromMap(Map<String, dynamic> map) {
    final Map _answers = map['answers'];
    // final List<String> _answerLetter = [];
    final Map<String, bool> _answersKeyValue = {};
    _answers.forEach((key, value) {
      if (value != null) {
        // _answerLetter.add(key);
        print(
            'KEYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYY\n$key'
            '\nKEYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYY');
        print('ANSWR A CORRECT\n${map['answer_a_correct']}'
            '\nANSWER A CORRECT');
        print('MAP\n$map'
            '\MAP');
        print(
            'OHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHH\n${map['${key}_correct']}\nOHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHH');
        _answersKeyValue.addAll({
          value:
              map['correct_answers']['${key}_correct'] == "false" ? false : true
        });
      }
    });
    late final bool _hasMultipleCorrectAnswers;
    if (map['multipleCorrectAnswers'] == "false") {
      _hasMultipleCorrectAnswers = false;
    } else {
      _hasMultipleCorrectAnswers = true;
    }
    final List<Answer> _answerList = [];
    _answersKeyValue.forEach((key, value) {
      _answerList.add(Answer(answer: key, isCorrect: value));
    });
    return Question(
      id: map['id'],
      question: map['question'],
      answers: List<Answer>.from(_answerList),
      multipleCorrectAnswers: _hasMultipleCorrectAnswers,
      correctAnswer: map['correctAnswer'],
      tags: List<Tag>.from(map['tags']?.map((x) => Tag.fromMap(x))),
      category: map['category'],
      difficulty: map['difficulty'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Question.fromJson(String source) =>
      Question.fromMap(json.decode(source));

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      id,
      question,
      answers,
      multipleCorrectAnswers,
      tags,
      category,
      difficulty,
    ];
  }
}

class Answer extends Equatable {
  final String answer;
  final bool isCorrect;
  Answer({
    required this.answer,
    required this.isCorrect,
  });

  Answer copyWith({
    String? answer,
    bool? isCorrect,
  }) {
    return Answer(
      answer: answer ?? this.answer,
      isCorrect: isCorrect ?? this.isCorrect,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'answer': answer,
      'isCorrect': isCorrect,
    };
  }

  factory Answer.fromMap(Map<String, dynamic> map) {
    return Answer(
      answer: map['answer'],
      isCorrect: map['isCorrect'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Answer.fromJson(String source) => Answer.fromMap(json.decode(source));

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [answer, isCorrect];
}

class Tag extends Equatable {
  final String name;
  Tag({
    required this.name,
  });

  Tag copyWith({
    String? name,
  }) {
    return Tag(
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
    };
  }

  factory Tag.fromMap(Map<String, dynamic> map) {
    return Tag(
      name: map['name'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Tag.fromJson(String source) => Tag.fromMap(json.decode(source));

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [name];
}
