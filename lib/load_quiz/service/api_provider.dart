import 'dart:io';
// import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:kouiz/load_quiz/model/quiz.dart';
// import 'package:http/http.dart' as http;

final apiProvider =
    Provider.family<Api, QuizSettings>((ref, settings) => Api(settings));
final quizFutureProvider =
    FutureProvider.family.autoDispose<Quiz, QuizSettings>((ref, settings) {
  final api = ref.watch(apiProvider(settings));
  final response = api.getQuiz();
  ref.maintainState = true;
  quizProvider = Provider<Quiz?>((ref) {
    return _fetchedQuiz;
  });
  return response;
});
//**TODO: refactor this into its own bloc */
late final quizProvider;
Quiz? _fetchedQuiz;

class Api {
  final QuizSettings settings;
  Api(this.settings);
  final apiKey = 'irmjzteXpf36YHysVLxWZgAhaZC1rD8T2KSP9xb5';
  final _url = 'https://quizapi.io/api/v1/questions/';
  final CancelToken cancelToken = CancelToken();
  final dio = Dio();
  Future<Quiz> getQuiz() async {
    try {
      return await _getQuiz(false);
    } catch (_) {
      return await _getQuiz(true);
    }
  }

  Future<Quiz> _getQuiz(bool retry) async {
    final response = await dio.get(_url,
        options: Options(
          // followRedirects: false,
          validateStatus: (statusCode) => statusCode! < 500,
          headers: {
            'X-Api-Key': apiKey,
            HttpHeaders.contentTypeHeader: 'application/json'
          },
        ),
        queryParameters: settings.toMap(retry: retry));
    final _res = _response(response);

    Quiz _quiz = Quiz.fromMap(response.data);
    _fetchedQuiz = _quiz;
    return _quiz;
  }

  _response(Response response) {
    switch (response.statusCode) {
      case 200:
        return response;
      case 401:
        throw UnauthorisedException(response.data.toString());
      case 404:
        throw InvalidInputException(response.data.toString());
      case 429:
        throw BadRequestException(response.data.toString());
      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode: ${response.statusCode}');
    }
  }
}

class CustomException implements Exception {
  final _message;
  final _prefix;

  CustomException([this._message, this._prefix]);

  String toString() {
    return "$_prefix$_message";
  }
}

class FetchDataException extends CustomException {
  FetchDataException([String? message])
      : super(message, "Error During Communication: ");
}

class BadRequestException extends CustomException {
  BadRequestException([message]) : super(message, "Invalid Request: ");
}

class UnauthorisedException extends CustomException {
  UnauthorisedException([message]) : super(message, "Unauthorised: ");
}

class InvalidInputException extends CustomException {
  InvalidInputException([String? message]) : super(message, "Invalid Input: ");
}
