import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture_example/core/error/failures.dart';
import 'package:flutter_clean_architecture_example/core/usecases/usecase.dart';
import 'package:flutter_clean_architecture_example/core/utils/input_converter.dart';
import 'package:flutter_clean_architecture_example/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:flutter_clean_architecture_example/features/number_trivia/domain/usecases/get_number_trivia_usecase.dart';
import 'package:flutter_clean_architecture_example/features/number_trivia/domain/usecases/get_random_number_trivia_usecase.dart';
import 'package:flutter_clean_architecture_example/features/number_trivia/presentation/bloc/bloc.dart';
import './bloc.dart';
import 'package:meta/meta.dart';

const String SERVER_FAILURE_MESSAGE = 'Server failure';
const String CACHE_FAILURE_MESSAGE = 'Cache failure';
const String INVALID_INPUT_FAILURE_MESSAGE =
    'Invalid Input - Input must be a positive integer.';

class NumbertriviaBloc extends Bloc<NumbertriviaEvent, NumbertriviaState> {
  final GetNumberTrivia getNumberTrivia;
  final GetRandomNumberTrivia getRandomNumberTrivia;
  final InputConverter inputConverter;

  NumbertriviaBloc({
    @required GetNumberTrivia concrete,
    @required GetRandomNumberTrivia random,
    @required this.inputConverter,
  })  : assert(concrete != null),
        assert(random != null),
        assert(inputConverter != null),
        getNumberTrivia = concrete,
        getRandomNumberTrivia = random;

  @override
  NumbertriviaState get initialState => Empty();

  @override
  Stream<NumbertriviaState> mapEventToState(
    NumbertriviaEvent event,
  ) async* {
    if (event is GetTriviaForNumber) {
      final inputEither = inputConverter.stringToInteger(event.numberString);
      yield* inputEither.fold(
        (failure) async* {
          yield Error(message: INVALID_INPUT_FAILURE_MESSAGE);
        },
        (integer) async* {
          yield Loading();
          final failureOrTrivia =
              await getNumberTrivia(Params(number: integer));
          yield* _eitherLoadedOrError(failureOrTrivia);
        },
      );
    } else if (event is GetTriviaForRandomNumber) {
      yield Loading();
      final failureOrTrivia = await getRandomNumberTrivia(NoParams());
      yield* _eitherLoadedOrError(failureOrTrivia);
    }
  }

  Stream<NumbertriviaState> _eitherLoadedOrError(
    Either<Failure, NumberTrivia> failureOrTrivia,
  ) async* {
    yield failureOrTrivia.fold(
      (failure) => Error(message: _mapFailureToMessage(failure)),
      (trivia) => Loaded(trivia: trivia),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case CacheFailure:
        return CACHE_FAILURE_MESSAGE;
      default:
        return 'Unexpected Error';
    }
  }
}
