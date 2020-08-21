import 'package:flutter/material.dart';
import 'gamePage.dart';
void main() => runApp(MyApp());


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hello Flutter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: GamePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}



