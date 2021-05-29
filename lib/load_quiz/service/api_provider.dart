import 'dart:io';
import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:kouiz/load_quiz/model/quiz.dart';
import 'package:http/http.dart' as http;

final apiProvider =
    Provider.family<Api, QuizSettings>((ref, settings) => Api(settings));
final quizFutureProvider =
    FutureProvider.family.autoDispose<Quiz, QuizSettings>((ref, settings) {
  final api = ref.watch(apiProvider(settings));
  final response = api.getQuiz();
  ref.maintainState = true;
  return response;
});

class GetQuizExcpetion {
  @override
  String toString() {
    return 'Error in fetching quiz';
  }
}

class Api {
  final QuizSettings settings;
  Api(this.settings);
  final apiKey = 'irmjzteXpf36YHysVLxWZgAhaZC1rD8T2KSP9xb5';

  Future<Quiz> getQuiz() async {
    try {
      return await _getQuiz(false);
    } catch (_) {
      return await _getQuiz(true);
    }
  }

  final client = http.Client();

  Future<Quiz> _getQuiz(bool retry) async {
    var _url = Uri.parse('https://quizapi.io/api/v1/questions/');
    _url = _url.replace(queryParameters: settings.toMap(retry: retry));

    final response = await http.get(
      _url,
      headers: {
        'X-Api-Key': apiKey,
        HttpHeaders.contentTypeHeader: 'application/json'
      },
    ).catchError((_) async {
      await _getQuiz(true);
    });

    Quiz _quiz = Quiz.fromMap(jsonDecode(response.body));
    return _quiz;
  }
}
