import 'package:flutter_clean_architecture_example/core/error/exceptions.dart';
import 'package:meta/meta.dart';
import 'dart:convert';
import 'package:flutter_clean_architecture_example/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class NumberTriviaLocalDatasource {
  /// Gets the cached [NumberTriviaModel] which was goten the last time
  /// the user had internet connection
  ///
  /// Throws [CacheException] if no cached data is found
  Future<NumberTriviaModel> getLastCachedNumberTrivia();
  Future<void> cacheNumberTrivia(NumberTriviaModel numberTriviaModel);
}

const CACHED_NUMBER_TRIVIA = 'CACHED_NUMBER_TRIVIA';

class NumberTriviaLocalDatasourceImpl implements NumberTriviaLocalDatasource {
  final SharedPreferences sharedPreferences;

  NumberTriviaLocalDatasourceImpl({@required this.sharedPreferences});

  @override
  Future<void> cacheNumberTrivia(NumberTriviaModel numberTriviaModel) {
    return sharedPreferences.setString(
        CACHED_NUMBER_TRIVIA, json.encode(numberTriviaModel.toJson()));
  }

  @override
  Future<NumberTriviaModel> getLastCachedNumberTrivia() {
    final jsonString = sharedPreferences.getString(CACHED_NUMBER_TRIVIA);
    if(jsonString != null){
      return Future.value(NumberTriviaModel.fromJson(json.decode(jsonString)));
    }else{
      throw CacheException();
    }
  }
}