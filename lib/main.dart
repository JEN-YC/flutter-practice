import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/blocObserver.dart';
import 'package:flutter_app/home/home_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'authentication/authentication_bloc.dart';
import 'firebase/firebase_messaging.dart';
import 'firebase/user_repository.dart';
import 'login/login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Bloc.observer = SimpleBlocObserver();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final UserRepository _userRepository = UserRepository();
  AuthenticationBloc _authenticationBloc;
  FirebaseMessaging _firebaseMessaging;

  @override
  void initState() {
    super.initState();
    _authenticationBloc = AuthenticationBloc(userRepository: _userRepository);
    _firebaseMessaging = configureMessaging();
    awaitThreeSeconds();
  }

  void awaitThreeSeconds() async {
    await Future.delayed(Duration(seconds: 5));
    _authenticationBloc.add(AppStartedEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => _authenticationBloc,
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
            builder: (context, state) {
              if (state is AuthenticatedState)
                return HomePage(
                  user: state.user,
                );
              else if (state is UnauthenticatedState)
                return LoginPage(
                  userRepository: _userRepository,
                );
              return Material(
                child: Center(
                    child: SizedBox(
                        width: 300.0,
                        child: TextLiquidFill(
                          text: 'Flutter',
                          waveColor: Colors.blueAccent,
                          boxBackgroundColor: Colors.red,
                          loadDuration: Duration(seconds: 4),
                          textStyle: TextStyle(
                            fontSize: 50.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ))),
              );
            },
          ),
        ));
  }
}
