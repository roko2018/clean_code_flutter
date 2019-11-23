import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture_example/core/error/failures.dart';
import 'package:flutter_clean_architecture_example/features/number_trivia/domain/entities/number_trivia.dart';

abstract class NumberTriviaRepository{
  Future<Either<Failure, NumberTrivia>> getNumberTrivia(int number);
  Future<Either<Failure, NumberTrivia>> getRandomNumberTrivia();
}