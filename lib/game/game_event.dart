part of 'game_bloc.dart';

abstract class GameEvent extends Equatable {
  const GameEvent();
}

class UserChooseEvent extends GameEvent {
  final index;

  const UserChooseEvent(this.index);
  @override
  List<Object> get props => [index];
}

class ResetEvent extends GameEvent {
  const ResetEvent();

  @override
  List<Object> get props => [];
}
