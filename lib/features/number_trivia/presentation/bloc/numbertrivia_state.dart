import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:flutter_clean_architecture_example/features/number_trivia/domain/entities/number_trivia.dart';

abstract class NumbertriviaState extends Equatable {
  NumbertriviaState([List props = const <dynamic>[]]) : super(props);
}

class Empty extends NumbertriviaState {}

class Loading extends NumbertriviaState {}

class Loaded extends NumbertriviaState {
  final NumberTrivia trivia;

  Loaded({@required this.trivia}) : super([trivia]);
}

class Error extends NumbertriviaState {
  final String message;

  Error({@required this.message}) : super([message]);
}
