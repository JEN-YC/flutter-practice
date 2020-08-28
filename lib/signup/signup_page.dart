import 'package:flutter/material.dart';
import 'package:flutter_app/signup/signup_bloc.dart';
import 'package:flutter_app/signup/signup_form.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../firebase/user_repository.dart';

class SignupPage extends StatelessWidget {
  final UserRepository _userRepository;
  SignupPage({Key key, @required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocProvider(
          create: (_) =>
              SignupBloc(userRepository: _userRepository),
          child: SignupForm(),
        ));
  }
}