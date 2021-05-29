import 'dart:io';
// import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kouiz/categories/service/category_provider.dart';

import 'package:kouiz/load_quiz/model/quiz.dart';
// import 'package:http/http.dart' as http;

final apiProvider = Provider.autoDispose<Api>((ref) => Api(ref.read));
final quizFutureProvider = FutureProvider.autoDispose<Quiz>((ref) {
  final api = ref.watch(apiProvider);
  final response = api.getQuiz();
  ref.maintainState = false;
  return response;
  // quizProvider = Provider<Quiz?>((ref) {
  //   return _fetchedQuiz;
  // });
  // return response;
});
//**TODO: refactor this into its own bloc */
// Provider<Quiz?>? quizProvider;
// Quiz? _fetchedQuiz;

class Api {
  final Reader _reader;
  // final QueryOptions _options;
  Api(this._reader);
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
    final options = _reader(quizSettingsProvider).quizSettings;
    final response = await dio.get(_url,
        cancelToken: cancelToken,
        options: Options(
          // followRedirects: false,
          validateStatus: (statusCode) => statusCode! < 500,
          headers: {
            'X-Api-Key': apiKey,
            HttpHeaders.contentTypeHeader: 'application/json'
          },
        ),
        queryParameters: options.toMap(retry: retry));
    final _res = _response(response);

    Quiz _quiz = Quiz.fromMap(response.data);
    // _fetchedQuiz = _quiz;
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
// final repositoryProvider = Provider.family<DataRepository, QueryOptions>(
//     (ref, options) => DataRepository(options));

// final futureProvider = FutureProvider.family<DataModel, QueryOptions>(
//   (ref, options) {
//     final repo = ref.watch(repositoryProvider(options));
//     return repo.getData();
//   },
// );

// class DataModel {}

// class QueryOptions {}

// class DataRepository {
//   const DataRepository(this.options) : _service = const ApiService();
//   final QueryOptions options;
//   final ApiService _service;
//   Future<DataModel> getData() async {
//     return await _service.getDataFromApi(options);
//   }
// }

// class ApiService {
//   const ApiService();
//   Future getDataFromApi(QueryOptions options) async {
//     return Future.value(DataModel());
//   }
// }

// class ParentWidget extends ConsumerWidget {
//   const ParentWidget({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context, ScopedReader watch) {
//     //QueryOptions depends on user action in the previous route so I pass them as an arguement
//     final QueryOptions options =
//         ModalRoute.of(context)!.settings.arguments as QueryOptions;
//     final value = watch(futureProvider(options));
//     return value.when(
//         data: (data) => ListView(
//               children: [
//                 //Complex and nested and needs access to my value
//                 ChildWidget1()
//                 //Complex and nested and needs access to my value
//                 ChildWidget2()
//                 //Complex and nested and needs access to my value
//                 ChildWidget3()

//               ],
//             ),
//         loading: () => Container(),
//         error: (_, __) => Container());
//   }
// }
