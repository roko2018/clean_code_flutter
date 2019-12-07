import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture_example/features/number_trivia/presentation/bloc/bloc.dart';

class TriviaControls extends StatefulWidget {
  TriviaControls({Key key}) : super(key: key);

  @override
  _TriviaControlsState createState() => _TriviaControlsState();
}

class _TriviaControlsState extends State<TriviaControls> {
  final controller = TextEditingController();
  String inputStr;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          TextField(
            controller: controller,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Enter a number',
            ),
            keyboardType: TextInputType.number,
            onChanged: (value) {
              inputStr = value;
            },
            onSubmitted: (_) {
              dispatchConcrete();
            },
          ),
          SizedBox(
            height: 12.0,
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: RaisedButton(
                  child: Text('Search'),
                  color: Theme.of(context).accentColor,
                  textTheme: ButtonTextTheme.primary,
                  onPressed: dispatchConcrete,
                ),
              ),
              SizedBox(
                width: 12.0,
              ),
              Expanded(
                child: RaisedButton(
                  child: Text('Get Random Trivia'),
                  onPressed: dispatchRandom,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void dispatchConcrete() {
    controller.clear();
    BlocProvider.of<NumbertriviaBloc>(context)
        .add(GetTriviaForNumber(inputStr));
  }

  void dispatchRandom() {
    controller.clear();
    BlocProvider.of<NumbertriviaBloc>(context).add(GetTriviaForRandomNumber());
  }
}
