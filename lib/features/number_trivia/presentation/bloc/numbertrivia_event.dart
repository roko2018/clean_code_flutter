import 'package:equatable/equatable.dart';

abstract class NumbertriviaEvent extends Equatable {
  NumbertriviaEvent([List props = const <dynamic>[]]) : super(props);
}

class GetTriviaForNumber extends NumbertriviaEvent {
  final String numberString;

  GetTriviaForNumber(this.numberString) : super([numberString]);
}

class GetTriviaForRandomNumber extends NumbertriviaEvent {}
