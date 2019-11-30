import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter_clean_architecture_example/core/network/network_info.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockDataConnectionChecker extends Mock implements DataConnectionChecker {}

void main() {
  NetworkInfoImpl networkInfo;
  MockDataConnectionChecker dataConnectionChecker;

  setUp(() {
    dataConnectionChecker = MockDataConnectionChecker();
    networkInfo = NetworkInfoImpl(dataConnectionChecker);
  });

  group(
    'isConnected',
    () {
      test(
          'should forward the call to DataConnectionChecker.hasConnection',
          () async {
            // arrange
            final tHasConnection = Future.value(true);
            when(dataConnectionChecker.hasConnection)
              .thenAnswer((_) => tHasConnection);
            // act
            final result = networkInfo.isConnected;
            // assert
            verify(dataConnectionChecker.hasConnection);
            expect(result, tHasConnection);
          },
        );
    },
  );
}
