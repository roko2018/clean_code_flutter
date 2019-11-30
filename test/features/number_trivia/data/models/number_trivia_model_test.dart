import 'package:flutter_clean_architecture_example/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:flutter_clean_architecture_example/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:flutter_test/flutter_test.dart';
import 'dart:convert';
import '../../../../fixtures/fixture_reader.dart';

void main() {
  final tNumberTriviaModel = NumberTriviaModel(number: 1, text: 'Test Text');

  test('should be a subclass of NumberTrivia class', () {
    expect(tNumberTriviaModel, isA<NumberTrivia>());
  });

  group(
    'fromJson',
    () {
      test(
        'should return a valid model when JSON number is an integer',
        () async {
          // arrange
          final Map<String, dynamic> jsonMap =
              json.decode(fixture("trivia.json"));
          // act
          final result = NumberTriviaModel.fromJson(jsonMap);
          // assert
          expect(result, tNumberTriviaModel);
        },
      );

      test(
        'should return a valid model when JSON number is double',
        () async {
          // arrange
          final Map<String, dynamic> jsonMap =
              json.decode(fixture("trivia_double.json"));
          // act
          final result = NumberTriviaModel.fromJson(jsonMap);
          // assert
          expect(result, tNumberTriviaModel);
        },
      );
    },
  );

  group('toJson', () {
    test(
      'should return a JSON map containing the proper data',
      () async {
        // arrange
        final testMap = {
          "text": "Test Text",
          "number": 1,
        };
        // act
        final result = tNumberTriviaModel.toJson();
        // assert
        expect(result, testMap);
      },
    );
  });
}
