import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'game_bloc.dart';

class GamePage extends StatefulWidget {
  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  GameBloc _gameBloc;

  @override
  void initState() {
    _gameBloc = new GameBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      lazy: false,
      create: (_) => _gameBloc,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Tic-Tac-Toe'),
        ),
        body: BlocBuilder<GameBloc, GameState>(builder: (context, state) {
          String statusText;
          if (state is GameInitState) {
            statusText = "Next turn ";
            statusText += state.isNextPlayerO ? "O" : "X";
          } else if (state is GamePlayingState) {
            statusText = "Next turn ";
            statusText += state.isNextPlayerO ? "O" : "X";
          } else if (state is GameEndWithWinnerState) {
            statusText = "Winner is ";
            statusText += state.isWinnerO ? "O" : "X";
          } else {
            statusText = "Tie Game";
          }
          return Container(
            decoration: BoxDecoration(color: Colors.amber),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Status(statusText),
                  BoxContainer(state.board)
                ],
              ),
            ),
          );
        }),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            bool reset = await _showAlertBox(context, 'Reset?',
                'Want to reset the current game?', 'Go Back', 'Reset');
            if (reset) _gameBloc.add(ResetEvent());
          },
          tooltip: 'Restart',
          child: Icon(Icons.refresh),
        ),
      ),
    );
  }
}

class BoxContainer extends StatelessWidget {
  final List<String> board;
  BoxContainer(this.board);
  @override
  Widget build(BuildContext context) {
    return Container(
        width: 350,
        height: 350,
        decoration: BoxDecoration(
            color: Colors.white,
            border: new Border.all(color: Colors.blue, width: 5),
            boxShadow: [
              BoxShadow(
                  color: Colors.red[200],
                  blurRadius: 10.0,
                  spreadRadius: 10.0,
                  offset: Offset(10.0, 10.0)),
            ]),
        child: Center(
            child: GridView.count(
          primary: false,
          crossAxisCount: 3,
          children: List.generate(9, (index) {
            return Box(index, context.bloc<GameBloc>().state.board[index]);
          }),
        )));
  }
}

class Box extends StatelessWidget {
  final int index;
  final String mark;
  Box(this.index, this.mark);
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
        padding: EdgeInsets.all(0),
        child: Container(
            decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                border: new Border.all(color: Colors.blue)),
            child: Center(
              child: Text(
                mark.toUpperCase(),
                style: TextStyle(
                  fontSize: 45,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )),
        onPressed: () => context.bloc<GameBloc>().add(UserChooseEvent(index)));
  }
}

class Status extends StatelessWidget {
  final String text;
  Status(this.text);
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(20),
        child: Container(
          color: Colors.white,
          width: 220,
          height: 60,
          padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
          child: Text(
            text,
            style: TextStyle(
              fontSize: 30,
            ),
            textAlign: TextAlign.center,
          ),
        ));
  }
}

Future<bool> _showAlertBox(BuildContext context, String title, String content,
    String btn1, String btn2) async {
  return showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext _context) => AlertDialog(
            title: Text(title.toUpperCase()),
            content: Text(content),
            actions: <Widget>[
              RaisedButton(
                color: Colors.white,
                child: Text(btn1),
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
              ),
              RaisedButton(
                color: Colors.white,
                child: Text(btn2),
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
              )
            ],
          ));
}
