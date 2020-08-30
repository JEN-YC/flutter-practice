import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/game/game_page.dart';
import 'package:flutter_app/home/side_drawer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomePage extends StatefulWidget {
  final User _user;
  HomePage({Key key, @required User user})
      : _user = user,
        super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectIndex = 0;
  static List<Widget> _widgetOption = <Widget>[
    GamePage(),
    Center(child: Text("Google Map"))
  ];
  void _onTap(int index) {
    setState(() {
      _selectIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideDrawer(user: widget._user),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.videogame_asset), title: Text('Tic-Tac-Toe')),
          BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.solidMap), title: Text('Mask Map')),
        ],
        backgroundColor: Colors.amber,
        onTap: _onTap,
        currentIndex: _selectIndex,
      ),
      body: Container(
        child: _widgetOption.elementAt(_selectIndex),
      ),
    );
  }
}
