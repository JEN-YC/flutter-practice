part of 'game_bloc.dart';

abstract class GameState extends Equatable {
  const GameState();

  List<String> get board;
}

class GameInitState extends GameState {

  final bool isNextPlayerO = true;

  const GameInitState();

  @override
  final List<String> board = const ['', '', '', '', '', '', '', '', ''];

  @override
  List<Object> get props => [] + [isNextPlayerO] + board;
}

class GamePlayingState extends GameState {
  @override
  final List<String> board;

  final bool isNextPlayerO;
  const GamePlayingState({this.board, this.isNextPlayerO});

  @override
  List<Object> get props => [] + [isNextPlayerO] + board;

  @override
  // TODO: implement stringify
  bool get stringify => true;
}

class GameEndWithWinnerState extends GameState {
  @override
  final List<String> board;
  final bool isWinnerO;

  const GameEndWithWinnerState({this.board, this.isWinnerO});

  @override
  List<Object> get props => [] + [isWinnerO] + board;
}

class GameEndWithoutWinnerState extends GameState {
  @override
  final List<String> board;

  const GameEndWithoutWinnerState({this.board});

  @override
  List<Object> get props => board;
}
