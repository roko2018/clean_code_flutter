import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_clean_architecture_example/core/error/failures.dart';
import 'package:flutter_clean_architecture_example/core/usecases/usecase.dart';
import 'package:flutter_clean_architecture_example/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:flutter_clean_architecture_example/features/number_trivia/domain/repositories/number_trivia_repository.dart';

class GetNumberTrivia implements UseCase<NumberTrivia, Params> {
  final NumberTriviaRepository repository;

  GetNumberTrivia(this.repository);

  @override
  Future<Either<Failure, NumberTrivia>> call(Params params) {
    return repository.getNumberTrivia(params.number);
  }
}

class Params extends Equatable {
  final int number;

  Params(this.number) : super([number]);
}
