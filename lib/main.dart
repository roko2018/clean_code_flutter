import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture_example/features/number_trivia/presentation/pages/number_trivia_page.dart';
import 'injection_container.dart' as ic;

void main() async {
  await ic.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Number Api',
      theme: ThemeData(
        primaryColor: Colors.blue.shade800,
        accentColor: Colors.blue.shade600,
      ),
      home: NumberTriviaPage(),
    );
  }
}
