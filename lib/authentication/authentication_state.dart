part of 'authentication_bloc.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();
}

class InitializedState extends AuthenticationState {
  @override
  List<Object> get props => [];
}

class AuthenticatedState extends AuthenticationState {
  final User user;
  const AuthenticatedState({this.user});

  @override
  List<Object> get props => [user];
}

class UnauthenticatedState extends AuthenticationState {
  @override
  List<Object> get props => [];
}
