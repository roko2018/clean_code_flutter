import 'package:flutter_clean_architecture_example/core/error/exceptions.dart';
import 'package:flutter_clean_architecture_example/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

abstract class NumberTriviaRemoteDatasource {
  /// Calls the http://numbersapi.com/{number} endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<NumberTriviaModel> getNumberTrivia(int number);

  /// Calls the http://numbersapi.com/random endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<NumberTriviaModel> getRandomNumberTrivia();
}

class NumberTriviaRemoteDatasourceImpl implements NumberTriviaRemoteDatasource {
  final http.Client client;

  NumberTriviaRemoteDatasourceImpl({this.client});

  @override
  Future<NumberTriviaModel> getNumberTrivia(int number) =>
      getTriviaFromUrl("http://numbersapi.com/$number");

  @override
  Future<NumberTriviaModel> getRandomNumberTrivia() =>
      getTriviaFromUrl("http://numbersapi.com/random");

  Future<NumberTriviaModel> getTriviaFromUrl(String url) async {
    final response = await client.get(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
    );
    if (response.statusCode == 200)
      return NumberTriviaModel.fromJson(json.decode(response.body));
    else
      throw ServerException();
  }
}
