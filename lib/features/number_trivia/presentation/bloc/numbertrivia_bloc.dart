import 'dart:async';
import 'package:bloc/bloc.dart';
import './bloc.dart';

class NumbertriviaBloc extends Bloc<NumbertriviaEvent, NumbertriviaState> {
  @override
  NumbertriviaState get initialState => InitialNumbertriviaState();

  @override
  Stream<NumbertriviaState> mapEventToState(
    NumbertriviaEvent event,
  ) async* {
    // TODO: Add Logic
  }
}
