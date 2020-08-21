import 'package:flutter/material.dart';
import 'dart:async';

int currentMoves;
List<String> _board; //empty board
String status;
String winner = '';
var _gamePageState;
var _turnState;
var _context;
String _turn;

class GamePage extends StatefulWidget {
  GamePage() {
    _resetGame();
  }
  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  @override
  Widget build(BuildContext context) {
    _gamePageState = this;

    return Scaffold(
      appBar: AppBar(
        title: Text('Tic-Tac-Toe'),
      ),
      body: Container(
        decoration: BoxDecoration(color: Colors.amber),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[Status(),_BoxContainer()],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            gameFinished('Reset?', 'Want to reset the current game?', 'Go Back',
                'Reset');
          });
        },
        tooltip: 'Restart',
        child: Icon(Icons.refresh),
      ),
    );
  }
}

class _BoxContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    _context = context;
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
            return Box(index);
          }),
        )));
  }
}

class Box extends StatefulWidget {
  final int index;
  Box(this.index);
  @override
  _BoxState createState() => _BoxState();
}

class _BoxState extends State<Box> {
  void pressed() {
    setState(() {
      currentMoves++;
      if (_checkGame()) {
        gameFinished("$winner won!", 'Want to try again?', 'Go Back', 'New Game');
      } else if (currentMoves >= 9) {
        gameFinished('It\'s a Draw', 'Want to try again?', 'Go Back', 'New Game');
      }
      _turnState.setState(() {
        if (currentMoves % 2 == 0)
          _turn = 'Turn: O';
        else
          _turn = 'Turn: X';
      });
    });
  }

  @override
  Widget build(context) {
    return MaterialButton(
        padding: EdgeInsets.all(0),
        child: Container(
            decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                border: new Border.all(color: Colors.blue)),
            child: Center(
              child: Text(
                _board[widget.index].toUpperCase(),
                style: TextStyle(
                  fontSize: 45,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )),
        onPressed: () {
          if (_board[widget.index] == '') {
            if (currentMoves % 2 == 0)
              _board[widget.index] = 'o';
            else
              _board[widget.index] = 'x';

            pressed();
          }
        });
  }
}

class Status extends StatefulWidget {
  @override
  _StatusState createState() => _StatusState();
}

class _StatusState extends State<Status> {
  @override
  Widget build(BuildContext context) {
    _turnState = this;
    return Container(
        margin: EdgeInsets.all(20),
        child: Container(
          color: Colors.white,
          width: 220,
          height: 60,
          padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
          child: Text(
            _turn,
            style: TextStyle(fontSize: 30, ),
            textAlign: TextAlign.center,
          ),
        ));
  }
}

bool _checkGame() {
  for (int i = 0; i < 9; i += 3) {
    if (_board[i] != '' &&
        _board[i] == _board[i + 1] &&
        _board[i + 1] == _board[i + 2]) {
      winner = _board[i];
      return true;
    }
  }
  for (int i = 0; i < 3; i++) {
    if (_board[i] != '' &&
        _board[i] == _board[i + 3] &&
        _board[i + 3] == _board[i + 6]) {
      winner = _board[i];
      return true;
    }
  }
  if (_board[0] != '' && (_board[0] == _board[4] && _board[4] == _board[8]) ||
      (_board[2] != '' && _board[2] == _board[4] && _board[4] == _board[6])) {
    winner = _board[4];
    return true;
  }
  return false;
}

void _resetGame() {
  currentMoves = 0;
  status = '';
  _board = ['', '', '', '', '', '', '', '', ''];
  _turn = 'First Move: O';
}

gameFinished(String title, String content, String btn1, String btn2) async {
  bool result = await _showAlertBox(_context, title, content, btn1, btn2);
  if (result) {
    _gamePageState.setState(() {
      _resetGame();
    });
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


