import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'game_event.dart';
part 'game_state.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  GameBloc() : super(GameInitState());

  List<String> board;
  int currentMoves;
  @override
  Stream<GameState> mapEventToState(
    GameEvent event,
  ) async* {
    final currentState = state;
    if (event is UserChooseEvent) {
      int index = event.index;
      if (currentState is GameInitState) {
        board = ['', '', '', '', '', '', '', '', ''];
        currentMoves = 1;
        board[index] = currentState.isNextPlayerO ? "O" : "X";
        yield GamePlayingState(
            board: board, isNextPlayerO: !currentState.isNextPlayerO);
      } else if (currentState is GamePlayingState) {
        if (board[index] == "") {
          board[index] = currentState.isNextPlayerO ? "O" : "X";
          currentMoves++;
          yield checkGameState(
              board, currentState.isNextPlayerO, currentMoves);
        }
      }
    } else if (event is ResetEvent) {
      yield GameInitState();
    }
  }

  GameState checkGameState(
      List<String> board, bool isNextPlayerO, int currentMoves) {
    for (int i = 0; i < 9; i += 3) {
      if (board[i] != '' &&
          board[i] == board[i + 1] &&
          board[i + 1] == board[i + 2]) {
        return GameEndWithWinnerState(board: board, isWinnerO: isNextPlayerO);
      }
    }
    for (int i = 0; i < 3; i++) {
      if (board[i] != '' &&
          board[i] == board[i + 3] &&
          board[i + 3] == board[i + 6]) {
        return GameEndWithWinnerState(board: board, isWinnerO: isNextPlayerO);
      }
    }
    if (board[0] != '' && (board[0] == board[4] && board[4] == board[8]) ||
        (board[2] != '' && board[2] == board[4] && board[4] == board[6])) {
      return GameEndWithWinnerState(board: board, isWinnerO: isNextPlayerO);
    }
    if (currentMoves == 9) return GameEndWithoutWinnerState(board: board);
    return GamePlayingState(board: board, isNextPlayerO: !isNextPlayerO);
  }
}
