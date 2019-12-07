import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture_example/features/number_trivia/presentation/bloc/numbertrivia_bloc.dart';
import 'package:flutter_clean_architecture_example/features/number_trivia/presentation/bloc/numbertrivia_state.dart';
import 'package:flutter_clean_architecture_example/features/number_trivia/presentation/widgets/loading_widget.dart';
import 'package:flutter_clean_architecture_example/features/number_trivia/presentation/widgets/message_display.dart';
import 'package:flutter_clean_architecture_example/features/number_trivia/presentation/widgets/trivia_controls.dart';
import 'package:flutter_clean_architecture_example/features/number_trivia/presentation/widgets/trivia_display.dart';
import 'package:flutter_clean_architecture_example/injection_container.dart';

class NumberTriviaPage extends StatelessWidget {
  const NumberTriviaPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Flutter Architecture',
        ),
      ),
      body: buildBody(context),
    );
  }
}

BlocProvider<NumbertriviaBloc> buildBody(BuildContext context) {
  return BlocProvider(
    builder: (_) => sl<NumbertriviaBloc>(),
    child: Center(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 12.0,
            ),
            BlocBuilder(
              builder: (context, state) {
                if (state is Empty) {
                  return MessageDisplay(
                    message: 'Start Searching ...',
                  );
                } else if (state is Loading) {
                  return LoadingWidget();
                } else if (state is Loaded) {
                  return TriviaDisplay(
                    trivia: state.trivia,
                  );
                } else if (state is Error) {
                  return MessageDisplay(
                    message: state.message,
                  );
                }
              },
            ),
            SizedBox(
              height: 20.0,
            ),
            TriviaControls(),
          ],
        ),
      ),
    ),
  );
}
